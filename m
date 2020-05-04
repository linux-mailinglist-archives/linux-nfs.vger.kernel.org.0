Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB81C46C3
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2020 21:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEDTHU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 May 2020 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgEDTHT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 May 2020 15:07:19 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A562BC061A0E
        for <linux-nfs@vger.kernel.org>; Mon,  4 May 2020 12:07:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 16564ABE; Mon,  4 May 2020 15:07:19 -0400 (EDT)
Date:   Mon, 4 May 2020 15:07:19 -0400
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH RFC] Frequent connection loss using krb5[ip] NFS mounts
Message-ID: <20200504190719.GB2757@fieldses.org>
References: <20200501184301.2324.22719.stgit@klimt.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501184301.2324.22719.stgit@klimt.1015granger.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, May 01, 2020 at 03:04:00PM -0400, Chuck Lever wrote:
> Over the past year or so I've observed that using sec=krb5i or
> sec=krb5p with NFS/RDMA while testing my Linux NFS client and server
> results in frequent connection loss. I've been able to pin this down
> a bit.
> 
> The problem is that SUNRPC's calls into the kernel crypto functions
> can sometimes reschedule. If that happens between the time the
> server receives an RPC Call and the time it has unwrapped the Call's
> GSS sequence number, the number is very likely to have fallen
> outside the GSS context's sequence number window. When that happens,
> the server is required to drop the Call, and therefore also the
> connection.

Does it help to increase GSS_SEQ_WIN?  I think you could even increase
it by a couple orders of magnitudes without getting into higher-order
allocations.

--b.

> 
> I've tested this observation by applying the following naive patch to
> both my client and server, and got the following results.
> 
> I. Is this an effective fix?
> 
> With sec=krb5p,proto=rdma, I ran a 12-thread git regression test
> (cd git/; make -j12 test).
> 
> Without this patch on the server, over 3,000 connection loss events
> are observed. With it, the test runs on a single connection. Clearly
> the server needs to have some kind of mitigation in this area.
> 
> 
> II. Does the fix cause a performance regression?
> 
> Because this patch affects both the client and server paths, I
> tested the performance differences between applying the patch in
> various combinations and with both sec=krb5 (which checksums just
> the RPC message header) and krb5i (which checksums the whole RPC
> message.
> 
> fio 8KiB 70% read, 30% write for 30 seconds, NFSv3 on RDMA.
> 
> -- krb5 --
> 
> unpatched client and server:
> Connect count: 3
> read: IOPS=84.3k, 50.00th=[ 1467], 99.99th=[10028] 
> write: IOPS=36.1k, 50.00th=[ 1565], 99.99th=[20579]
> 
> patched client, unpatched server:
> Connect count: 2
> read: IOPS=75.4k, 50.00th=[ 1647], 99.99th=[ 7111]
> write: IOPS=32.3k, 50.00th=[ 1745], 99.99th=[ 7439]
> 
> unpatched client, patched server:
> Connect count: 1
> read: IOPS=84.1k, 50.00th=[ 1467], 99.99th=[ 8717]
> write: IOPS=36.1k, 50.00th=[ 1582], 99.99th=[ 9241]
> 
> patched client and server:
> Connect count: 1
> read: IOPS=74.9k, 50.00th=[ 1663], 99.99th=[ 7046]
> write: IOPS=31.0k, 50.00th=[ 1762], 99.99th=[ 7242]
> 
> -- krb5i --
> 
> unpatched client and server:
> Connect count: 6
> read: IOPS=35.8k, 50.00th=[ 3228], 99.99th=[49546]
> write: IOPS=15.4k, 50.00th=[ 3294], 99.99th=[50594]
> 
> patched client, unpatched server:
> Connect count: 5
> read: IOPS=36.3k, 50.00th=[ 3228], 99.99th=[14877]
> write: IOPS=15.5k, 50.00th=[ 3294], 99.99th=[15139]
> 
> unpatched client, patched server:
> Connect count: 3
> read: IOPS=35.7k, 50.00th=[ 3228], 99.99th=[15926]
> write: IOPS=15.2k, 50.00th=[ 3294], 99.99th=[15926]
> 
> patched client and server:
> Connect count: 3
> read: IOPS=36.3k, 50.00th=[ 3195], 99.99th=[15139]
> write: IOPS=15.5k, 50.00th=[ 3261], 99.99th=[15270]
> 
> 
> The good news:
> Both results show that I/O tail latency improves significantly when
> either the client or the server has this patch applied.
> 
> The bad news:
> The krb5 performance result shows an IOPS regression when the client
> has this patch applied.
> 
> 
> So now I'm trying to understand how to come up with a solution that
> prevents the rescheduling/connection loss issue without also
> causing a performance regression.
> 
> Any thoughts/comments/advice appreciated.
> 
> ---
> 
> Chuck Lever (1):
>       SUNRPC: crypto calls should never schedule
> 
> --
> Chuck Lever
