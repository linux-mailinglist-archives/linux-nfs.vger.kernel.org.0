Return-Path: <linux-nfs+bounces-12249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D3AD38BE
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C840B9E089C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A78129B8F5;
	Tue, 10 Jun 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4yNHKBH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D38429B78F
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560694; cv=none; b=EytTOfMCaQn+KVD4dTJYPdi8k1RLGJcgZjw4VQveuGa6sP2/DHci3JEpdwbsqldjRXrpmsXgIBH2qeP5H3L0I01p2CCwFHQTCAtLSXWX8DogejgN+ITIQPiDpLAsYKvYUv2Nnw0dShb573qM3PDgTANQUoueV9dyuEvkrOuz7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560694; c=relaxed/simple;
	bh=J/xX/9hVdJNjJCEUQHepQKMX9T3KWTRHW+BYkOZRS+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okyVI91nhGFi5Df9ZqDYl9x31Nbvni689ekqVhZrv6xOGogwc4wbypPXyzNgamwyKIjXcF24nTmAJDc1rvhNi7dDkpfkgjhuUIBXC2dTm1wreky5OtEtUsrbdFGxagAjmaowZgfVYSO/3u8wVVdx5jvWzDc/q7ixKYpp9QLN0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4yNHKBH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749560691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LINTLF05L1koMj92LkoI9kK4P6gmPFmZmyc9vyR2adA=;
	b=a4yNHKBHQ8liYL9yFRufZa/tt2qN+mOnpOzIpI5fvWadt3j+R8N0JYfXAHUIi/2Cv4TCr6
	R5ENpbxfP4pm/267GnOCWJQsPm9Zk93gkpY9WXt+1ylJIY4R7G7OttoSEBH1Lz5K0QuKYW
	NwIrA6xMZiELRbTG30II/dRDDndQxgc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-9VhxLoq2OYmwM6ny0Lwxmw-1; Tue,
 10 Jun 2025 09:04:48 -0400
X-MC-Unique: 9VhxLoq2OYmwM6ny0Lwxmw-1
X-Mimecast-MFC-AGG-ID: 9VhxLoq2OYmwM6ny0Lwxmw_1749560687
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 703601828AB9;
	Tue, 10 Jun 2025 13:04:46 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79AE918002B4;
	Tue, 10 Jun 2025 13:04:45 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] nfs: new tracepoint in match_stateid operation
Date: Tue, 10 Jun 2025 09:04:43 -0400
Message-ID: <9BD9513B-972A-4C83-9100-A11F289191E5@redhat.com>
In-Reply-To: <20250603-nfs-tracepoints-v1-4-d2615f3bbe6c@kernel.org>
References: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
 <20250603-nfs-tracepoints-v1-4-d2615f3bbe6c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 3 Jun 2025, at 7:42, Jeff Layton wrote:

> Add new tracepoints in the NFSv4 match_stateid minorversion op that sho=
w
> the info in both stateids.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/nfs4proc.c  |  4 ++++
>  fs/nfs/nfs4trace.h | 56 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 341740fa293d8fb1cfabe0813c7fcadf04df4f62..80126290589aaccd801c896=
5252523894e37c44a 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -10680,6 +10680,8 @@ nfs41_free_lock_state(struct nfs_server *server=
, struct nfs4_lock_state *lsp)
>  static bool nfs41_match_stateid(const nfs4_stateid *s1,
>  		const nfs4_stateid *s2)
>  {
> +	trace_nfs41_match_stateid(s1, s2);
> +
>  	if (s1->type !=3D s2->type)
>  		return false;
>
> @@ -10697,6 +10699,8 @@ static bool nfs41_match_stateid(const nfs4_stat=
eid *s1,
>  static bool nfs4_match_stateid(const nfs4_stateid *s1,
>  		const nfs4_stateid *s2)
>  {
> +	trace_nfs4_match_stateid(s1, s2);
> +
>  	return nfs4_stateid_match(s1, s2);
>  }
>
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index 73a6b60a848066546c2ae98b4982b0ab36bb0f73..9b56ce9f2f3dcb31a3e21d5=
740bcf62aca814214 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -1497,6 +1497,62 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_=
event,
>  DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_recall);
>  DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_layoutrecall_file);
>
> +#define show_stateid_type(type) \
> +	__print_symbolic(type, \
> +		{ NFS4_INVALID_STATEID_TYPE, "INVALID" }, \
> +		{ NFS4_SPECIAL_STATEID_TYPE, "SPECIAL" }, \
> +		{ NFS4_OPEN_STATEID_TYPE, "OPEN" }, \
> +		{ NFS4_LOCK_STATEID_TYPE, "LOCK" }, \
> +		{ NFS4_DELEGATION_STATEID_TYPE, "DELEGATION" }, \
> +		{ NFS4_LAYOUT_STATEID_TYPE, "LAYOUT" },	\
> +		{ NFS4_PNFS_DS_STATEID_TYPE, "PNFS_DS" }, \
> +		{ NFS4_REVOKED_STATEID_TYPE, "REVOKED" })

Let's add NFS4_FREED_STATEID_TYPE at the end here, for after 77be29b7a3f8=
9.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


