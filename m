Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908AA7D002C
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjJSRFw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjJSRFw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 13:05:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06313A
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 10:05:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398D3C433C8;
        Thu, 19 Oct 2023 17:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697735149;
        bh=I12O6zyahlw76Xd/pZ0xc4sjZzkfi2bIU7AEE9LlH7I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d+BP7t4PaMSuWpBEwQOakub6Y5OATZ2EeIiQ4Pppmp1QWfBKVsWeWA4Kq+rv/8jYN
         cB4jiB0zTM1EZlK08QQwn6EKLZsdTRZrFVvgQkI1+G2CgyuN9HUB+ntSEbg8w09Oed
         +5BJij3yjWXlm3Mf1LiA+lthL2zgIEXrFi6MPpxYwbMCnGfcv0hKaO9Qi/x5kEynIe
         B8P7m83PO+UYXsih8RLAfhT5pg9t0WA2cvIHlZT4uVLyU5k3yOsBKrt4sg5oEvAjl8
         YLu2W4T4D4yzvZQdG4ngIA1CEIMEfICQDuZEn0JF+ALGuNFTydpt2bVAyhkcbAyoko
         jhWA8udXUPLug==
Message-ID: <e93cf76e19e8d868874fdcc2939b63f22396253b.camel@kernel.org>
Subject: Re: [RESEND PATCH v2] NFSv4: fairly test all delegations on a SEQ4_
 revocation
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 19 Oct 2023 13:05:47 -0400
In-Reply-To: <20231019155922.6549-1-bcodding@redhat.com>
References: <20231019155922.6549-1-bcodding@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-10-19 at 11:59 -0400, Benjamin Coddington wrote:
> When the client is required to use TEST_STATEID to discover which
> delegation(s) have been revoked, it may continually test delegations at t=
he
> head of the list if the server continues to be unsatisfied and send
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED.  For a large number of delegations
> this behavior is prone to live-lock because the client may never be able =
to
> test and free revoked state at the end of the list since the
> SEQ4_STATUS_RECALLABLE_STATE_REVOKED will cause us to flag delegations at
> the head of the list to be tested.  This problem is further exacerbated b=
y
> the state manager's willingness to be scheduled out on a busy system whil=
e
> testing the list of delegations.
>=20
> Keep a generation counter for each attempt to test all delegations, and
> skip delegations that have already been tested in the current pass.
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/delegation.c       | 7 ++++++-
>  fs/nfs/delegation.h       | 1 +
>  include/linux/nfs_fs_sb.h | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
>=20
> --
>=20
> Changed on v2: remove extra brackets that had my debug statements
>=20
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index cf7365581031..fa1a14def45c 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -448,6 +448,7 @@ int nfs_inode_set_delegation(struct inode *inode, con=
st struct cred *cred,
>  	delegation->cred =3D get_cred(cred);
>  	delegation->inode =3D inode;
>  	delegation->flags =3D 1<<NFS_DELEGATION_REFERENCED;
> +	delegation->test_gen =3D 0;
>  	spin_lock_init(&delegation->lock);
> =20
>  	spin_lock(&clp->cl_lock);
> @@ -1294,6 +1295,8 @@ static int nfs_server_reap_expired_delegations(stru=
ct nfs_server *server,
>  	struct inode *inode;
>  	const struct cred *cred;
>  	nfs4_stateid stateid;
> +	unsigned long gen =3D ++server->delegation_gen;
> +
>  restart:
>  	rcu_read_lock();
>  restart_locked:
> @@ -1303,7 +1306,8 @@ static int nfs_server_reap_expired_delegations(stru=
ct nfs_server *server,
>  		    test_bit(NFS_DELEGATION_RETURNING,
>  					&delegation->flags) ||
>  		    test_bit(NFS_DELEGATION_TEST_EXPIRED,
> -					&delegation->flags) =3D=3D 0)
> +					&delegation->flags) =3D=3D 0 ||
> +			delegation->test_gen =3D=3D gen)
>  			continue;
>  		inode =3D nfs_delegation_grab_inode(delegation);
>  		if (inode =3D=3D NULL)
> @@ -1312,6 +1316,7 @@ static int nfs_server_reap_expired_delegations(stru=
ct nfs_server *server,
>  		cred =3D get_cred_rcu(delegation->cred);
>  		nfs4_stateid_copy(&stateid, &delegation->stateid);
>  		spin_unlock(&delegation->lock);
> +		delegation->test_gen =3D gen;
>  		clear_bit(NFS_DELEGATION_TEST_EXPIRED, &delegation->flags);
>  		rcu_read_unlock();
>  		nfs_delegation_test_free_expired(inode, &stateid, cred);
> diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
> index 1c378992b7c0..a6f495d012cf 100644
> --- a/fs/nfs/delegation.h
> +++ b/fs/nfs/delegation.h
> @@ -21,6 +21,7 @@ struct nfs_delegation {
>  	fmode_t type;
>  	unsigned long pagemod_limit;
>  	__u64 change_attr;
> +	unsigned long test_gen;
>  	unsigned long flags;
>  	refcount_t refcount;
>  	spinlock_t lock;
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 20eeba8b009d..2f9d380b3439 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -238,6 +238,7 @@ struct nfs_server {
>  	struct list_head	delegations;
>  	struct list_head	ss_copies;
> =20
> +	unsigned long		delegation_gen;
>  	unsigned long		mig_gen;
>  	unsigned long		mig_status;
>  #define NFS_MIG_IN_TRANSITION		(1)

Looks like a reasonable thing to do.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
