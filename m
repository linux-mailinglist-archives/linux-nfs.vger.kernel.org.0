Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41714A0530
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfH1Okd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 10:40:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfH1Okd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 10:40:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B21E281D1;
        Wed, 28 Aug 2019 14:40:33 +0000 (UTC)
Received: from parsley.fieldses.org (ovpn-125-160.rdu2.redhat.com [10.10.125.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 125F45D6B0;
        Wed, 28 Aug 2019 14:40:33 +0000 (UTC)
Received: by parsley.fieldses.org (Postfix, from userid 2815)
        id E563F18046C; Wed, 28 Aug 2019 10:40:31 -0400 (EDT)
Date:   Wed, 28 Aug 2019 10:40:31 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190828144031.GB14249@parsley.fieldses.org>
References: <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
 <20190827145819.GB9804@fieldses.org>
 <20190827145912.GC9804@fieldses.org>
 <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
 <20190828134839.GA26492@fieldses.org>
 <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
 <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
 <20190828140044.GA14249@parsley.fieldses.org>
 <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
 <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 28 Aug 2019 14:40:33 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 28, 2019 at 10:16:09AM -0400, Jeff Layton wrote:
> For the most part, these sorts of errors tend to be rare. If it turns
> out to be a problem we could consider moving the verifier into
> svc_export or something?

As Trond says, this isn't really a server implementation issue, it's a
protocol issue.  If a client detects when to resend writes by storing a
single verifier per server, then returning different verifiers from
writes to different exports will have it resending every time it writes
to one export then another.

--b.
