Return-Path: <linux-nfs+bounces-13876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED860B32C94
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Aug 2025 01:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918B656403C
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Aug 2025 23:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C03224AE6;
	Sat, 23 Aug 2025 23:47:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A74D599
	for <linux-nfs@vger.kernel.org>; Sat, 23 Aug 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755992858; cv=none; b=AfUWH60bvMb24vfbNEHschQB/AJqLeayW7uip25UGPAUh/hfw2bkx06iTAmSMStXhY6IWLDNp0O9yN3WMRjrmjrXXx2eMTcfX7zxH8t/iZdKIMj0fRAuZRjQXouBZ+XdTSQFsxEajzPyCg0L5Jr9xnD3WYi+Du1iJNThSBFWwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755992858; c=relaxed/simple;
	bh=q7ywotwb2ote0bK5hZlsyOhyNgRb7XAIOd7JU/+FUXo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NBxfO4wTw9cghpRPesJTs8MlwOam27gw5YWf2263Z/XXBviQ5M3OcZqIXwg1PMJZ/2wfBzZ8qgVtiIaSTVuW9qASLrJwwbO8W2Hg3tA1HGMuaIZnukE0gwfBDeoWa/mwZfkAuoK6vBDdfe7XywFW7Y3VLnx4sZ+ztfFDYuR90hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upxxC-006z4h-Jb;
	Sat, 23 Aug 2025 23:47:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 Dai.Ngo@oracle.com, tom@talpey.com
Subject: Re: [RFC PATCH 1/1] nfsd: delay re-registering of listeners after
 listener removal
In-reply-to: <20250821204328.89218-1-okorniev@redhat.com>
References: <20250821204328.89218-1-okorniev@redhat.com>
Date: Sun, 24 Aug 2025 09:47:23 +1000
Message-id: <175599284398.2234665.652565605474101171@noble.neil.brown.name>

On Fri, 22 Aug 2025, Olga Kornievskaia wrote:
> This patch tries to address the following failure:
> nfsdctl threads 0
> nfsdctl listener +rdma::20049
> nfsdctl listener +tcp::2049
> nfsdctl listener -tcp::2049
> nfsdctl: Error: Cannot assign requested address
>=20
> The reason for the failure is due to the fact that socket cleanup only
> happens in __svc_rdma_free() which is a deferred work triggers when an
> rdma transport is destroyed. To remove a listener nfsdctl is forced to
> first remove all transports via svc_xprt_destroy_all() and then re-add
> the ones that are left. Due to the fact that there isn't a way to
> delete a particular entry from a list where permanent sockets are
> stored. Going back to the deferred work done in __svc_rdma_free(), the

What particular part of __svc_rdma_free() needs to run in order for a
subsequent registration to succeed?
Can that bit be run directory from svc_rdma_free() rather than be
delayed?
(I know almost nothing about rdma so forgive me if the answers to these
questions seems obvious)

Thanks,
NeilBrown


> work might not get to run before nfsd_nl_listener_set_doit() creates
> the new transports. As a result, it finds that something is still
> listening of the rdma port and rdma_bind_addr() fails.
>=20
> Proposed solution is to add a delay after svc_xprt_destroy_all() to
> allow for the deferred work to run.
>=20
> --- Is the chosen value of 1s enough to ensure socket goes away?
> I can't guarantee that.
>=20
> --- Alternatives that i can think of:
> (1) to go back to listener removal approach that added removal of
> entry to the llist api. That would not require a removal of all
> transport causing this problem to occur. Earlier it was preferred
> not to change llist api.
> (2) some method of checking that all deferred work occuring in
> svc_xprt_destroy_all() completed.
>=20
> Fixes: d093c90892607 ("nfsd: fix management of listener transports")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfsctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index dd3267b4c203..f9f5670abcc3 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1998,8 +1998,10 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, s=
truct genl_info *info)
>  	 * Since we can't delete an arbitrary llist entry, destroy the
>  	 * remaining listeners and recreate the list.
>  	 */
> -	if (delete)
> +	if (delete) {
>  		svc_xprt_destroy_all(serv, net, false);
> +		ssleep(1);
> +	}
> =20
>  	/* walk list of addrs again, open any that still don't exist */
>  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> --=20
> 2.47.1
>=20
>=20


