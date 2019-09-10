Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7BAEB8E
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 15:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfIJN2i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 09:28:38 -0400
Received: from fieldses.org ([173.255.197.46]:32828 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfIJN2i (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Sep 2019 09:28:38 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4F1632010; Tue, 10 Sep 2019 09:28:37 -0400 (EDT)
Date:   Tue, 10 Sep 2019 09:28:37 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     chuck.lever@oracle.com, simo@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] add hash of the kerberos principal to the data
 being tracked by nfsdcld
Message-ID: <20190910132837.GB26695@fieldses.org>
References: <20190909201031.12323-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909201031.12323-1-smayhew@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applying for 5.4, thanks--b.

On Mon, Sep 09, 2019 at 04:10:29PM -0400, Scott Mayhew wrote:
> At the spring bakeathon, Chuck suggested that we should store the
> kerberos principal in addition to the client id string in nfsdcld.  The
> idea is to prevent an illegitimate client from reclaiming another
> client's opens by supplying that client's id string.
> 
> The first patch lays some groundwork for supporting multiple message
> versions for the nfsdcld upcalls, adding fields for version and message
> length to the nfsd4_client_tracking_ops (these fields are only used for
> the nfsdcld upcalls and ignored for the other tracking methods), as well
> as an upcall to get the maximum version supported by the userspace
> daemon.
> 
> The second patch actually adds the v2 message, which adds the sha256 hash
> of the kerberos principal to the Cld_Create upcall and to the Cld_GraceStart
> downcall (which is what loads the data in the reclaim_str_hashtbl).
> 
> Changes since v1:
> - use the sha256 hash of a principal instead of the principal itself
> - prefer the cr_raw_principal (returned by gssproxy) if it exists, then
>   fall back to cr_principal (returned by both gssproxy and rpc.svcgssd)
> 
> Scott Mayhew (2):
>   nfsd: add a "GetVersion" upcall for nfsdcld
>   nfsd: add support for upcall version 2
> 
>  fs/nfsd/nfs4recover.c         | 388 ++++++++++++++++++++++++++++------
>  fs/nfsd/nfs4state.c           |   6 +-
>  fs/nfsd/state.h               |   3 +-
>  include/uapi/linux/nfsd/cld.h |  41 +++-
>  4 files changed, 371 insertions(+), 67 deletions(-)
> 
> -- 
> 2.17.2
