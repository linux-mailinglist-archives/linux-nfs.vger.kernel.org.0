Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650032C18BF
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 23:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbgKWWpx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 17:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731732AbgKWWpw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 23 Nov 2020 17:45:52 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B42C206D8;
        Mon, 23 Nov 2020 22:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171551;
        bh=YeXORuYvulv58OJVqFhqjrxZD3NOKTu9giy9B55KELE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v11MAbFCOMmcb16mWdAMQrYjbaNbGjQ0wm1IPEho8zk2IMcJB5E6kfSiGmKEEmqJg
         ThQHAgMIcK9qhIGPpLDRYlwcl96szEHMt6M5C3I369lDQ+O40XM1WP0u8tXfknh4Ad
         nN2xRbHTymFzMcxtbYjNod4z02uZoFi6pWoCZ9SI=
Date:   Mon, 23 Nov 2020 16:46:05 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 016/141] nfsd: Fix fall-through warnings for Clang
Message-ID: <20201123224605.GF21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <0669408377bdc6ee87b214b2756465a6edc354fc.1605896059.git.gustavoars@kernel.org>
 <BF1128CE-4339-4145-9766-4EE7A5F58B5F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF1128CE-4339-4145-9766-4EE7A5F58B5F@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 20, 2020 at 01:27:51PM -0500, Chuck Lever wrote:
> 
> 
> > On Nov 20, 2020, at 1:26 PM, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
> > 
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> > warnings by explicitly adding a couple of break statements instead of
> > just letting the code fall through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > fs/nfsd/nfs4state.c | 1 +
> > fs/nfsd/nfsctl.c    | 1 +
> > 2 files changed, 2 insertions(+)
> > 
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index d7f27ed6b794..cdab0d5be186 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -3113,6 +3113,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > 			goto out_nolock;
> > 		}
> > 		new->cl_mach_cred = true;
> > +		break;
> > 	case SP4_NONE:
> > 		break;
> > 	default:				/* checked by xdr code */
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index f6d5d783f4a4..9a3bb1e217f9 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1165,6 +1165,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
> > 		inode->i_fop = &simple_dir_operations;
> > 		inode->i_op = &simple_dir_inode_operations;
> > 		inc_nlink(inode);
> > +		break;
> > 	default:
> > 		break;
> > 	}
> > -- 
> > 2.27.0
> > 
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>

Thanks, Chuck.
--
Gustavo
