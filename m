Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5749D191344
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 15:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCXOd4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 10:33:56 -0400
Received: from fieldses.org ([173.255.197.46]:53156 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgCXOd4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 10:33:56 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 34B18201A; Tue, 24 Mar 2020 10:33:56 -0400 (EDT)
Date:   Tue, 24 Mar 2020 10:33:56 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Yihao Wu <wuyihao@linux.alibaba.com>
Subject: Re: [PATCH] nfsd: fix race between cache_clean and cache_purge
Message-ID: <20200324143356.GA11065@fieldses.org>
References: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
 <8B2BC124-6911-46C9-9B01-A237AC149F0A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B2BC124-6911-46C9-9B01-A237AC149F0A@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 24, 2020 at 09:38:55AM -0400, Chuck Lever wrote:
> Mechanically this looks OK, but I would feel more comfortable
> if a domain expert could review this. Neil, Trond, Bruce?

Looks right to me.

Reviewed-by: J. Bruce Fields <bfields@redhat.com>

--b.
