Return-Path: <linux-nfs+bounces-21448-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KVFOg9M/mllowAAu9opvQ
	(envelope-from <linux-nfs+bounces-21448-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 22:48:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C94FBA0D
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 22:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46D5E3050F41
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2026 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A03D903C;
	Fri,  8 May 2026 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJBj/nls"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBC31355D;
	Fri,  8 May 2026 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273243; cv=none; b=EvoCj3M+F0J+LOzdiHtt6+11NW5gmGnj9XEnp4SPz/z5px57IoncLMEa3UpeUYDueR4eqDJDhY4M+uOCKv5wBmOpiY+EzMGxrWMVv0z4p+iU5jFybLHv0eY4uJEfVpCRculFXMx/577lOO6ZdxcYYrFkHPqYTqLnxmjQ6/+7q2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273243; c=relaxed/simple;
	bh=04eERtcYZTyoE47VoMdJU6HTayMdgVwWdiPoUM+EL4U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D74xaFJwY3VLY27rqz+oL0tzcGKGtfdyISNpr04Fh4DhibfPW5ooo0WtaroA+WDhQ42ZsHL9QM62TIS9vfZDi/96zMtPKjoqVTWll6iJXq+RIVZg/MuLxTZzTNsf91VVTUJBxTGfge17gm/pBcB5u+CqC0eP8/4duOpka3yjzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJBj/nls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9D9C4AF09;
	Fri,  8 May 2026 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778273243;
	bh=04eERtcYZTyoE47VoMdJU6HTayMdgVwWdiPoUM+EL4U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mJBj/nls3ManCWyQSlhPYwmdaLHRMLeWkqnGFTnPAG2rpztneFvOtCIaEfU5OoiR8
	 lms+cgRAHF0Lej0hss+pXS4iPi9y0Rwp/ClCEHVxhDSe7htjQ0RoQCQFNBFtNkTouK
	 z7HVoUOzyP3yDgI3WsfkkMvQNN1BWun/oVAEOnWD+sjD96iBnpBFN07vuCklmAEA/F
	 9lvA89N+6yhUp27Vbx/2zFmMY6Hpu5t2JdyHXCvQtcqXIxkaHLk5lIDHMfUYOqAg73
	 DjAzcXXjBfFLFbaHNq8Y8Fx5Wz6loQE8QBHbOMi1lDf9lje5IaNU4q3fPuLyiVMkEh
	 jckyGcA4v/SBw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B4EDDF40068;
	Fri,  8 May 2026 16:47:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 08 May 2026 16:47:21 -0400
X-ME-Sender: <xms:2Uv-aVNW1fik5aFtyr7DpI-syjHyY0EuoeR4ksM-WHyqpaBDAIJBIg>
    <xme:2Uv-aSwndwjA6_qu79FiaohOJVCldg5wGuXptClSA6wkxfSEvoxWLZ_sK4nQK84gg
    dhKEo43Vz07PAt3zKBp0wfHJoMc5bIm_79OSftKAi8lHNG-fTLQ7dzB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtoheptghhvghnghiihhhihhgrohdusehhuhgrfigvihdrtghomh
    dprhgtphhtthhopehlihhlihhnghhfvghnghefsehhuhgrfigvihdrtghomhdprhgtphht
    thhopeihrghnghgvrhhkuhhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopeihihdrii
    hhrghngheshhhurgifvghirdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2Uv-aelzVK-ApK6ClCAM4eOxrZ--L00HIOteXsyCBY5FXhvKwEwxVA>
    <xmx:2Uv-ab-0EwuWJuvw7yngbx9G9mkus8IyycQSMBlZ8KK_7a_phPm6RA>
    <xmx:2Uv-aSM3l1icMyq-rWooftcuYglq9k-zqw8JNNSwFrJghQkO7aRF2w>
    <xmx:2Uv-aV-JVQgNffrGuXzGrzi0cLaQMP9eV8bMrY5QOnlLAYn6WVxsuw>
    <xmx:2Uv-aaKe14bYymZDA0Ejj4Z8ByvgGJ1YXmtqt8tc5EKCTMslB16xTr1e>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A2B5780070; Fri,  8 May 2026 16:47:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxcNF55tVgJk
Date: Fri, 08 May 2026 16:47:00 -0400
From: "Chuck Lever" <cel@kernel.org>
To: yangerkun <yangerkun@huawei.com>,
 "Misbah Anjum N" <misanjum@linux.ibm.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 yi.zhang@huawei.com, "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Li Lingfeng" <lilingfeng3@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <f4caa4fa-f15f-4c95-8318-d4ec216e6090@app.fastmail.com>
In-Reply-To: <39819ad4-3105-4802-b5e2-79e131b25984@huawei.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
 <c45779f6-fe6c-4037-bb1c-01cfbbaa8aac@huawei.com>
 <76a10e49-54a6-4813-8b58-b7cd0820fdc6@app.fastmail.com>
 <4bb9ed6b-1a64-406a-9239-b0560ca963cc@huawei.com>
 <05f93fc4-59d7-4735-bc7d-a00d1497687a@huawei.com>
 <10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com>
 <39819ad4-3105-4802-b5e2-79e131b25984@huawei.com>
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in cache
 content files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 532C94FBA0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21448-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Hi Erkun -

On Fri, May 8, 2026, at 9:00 AM, yangerkun wrote:
> =E5=9C=A8 2026/5/8 16:16, yangerkun =E5=86=99=E9=81=93:
>>=20
>>=20
>> =E5=9C=A8 2026/5/8 11:08, yangerkun =E5=86=99=E9=81=93:
>> After reviewing these two commits:
>>=20
>> e7fcf179b82d NFSD: Hold net reference for the lifetime of /proc/fs/nf=
s/=20
>> exports fd
>> 48db892356d6 NFSD: Defer sub-object cleanup in export put callbacks
>>=20
>> I believe that the issue described in commit e7fcf179b82d might be the
>> root cause of the null pointer dereferences mentioned in [1].

That's where I landed too. e7fcf179b82d closed the specific
oops Misbah hit on /proc/fs/nfs/exports. The matching patch
in this series is 5/6 ("SUNRPC: Hold cd->net for the lifetime
of cache files"), which extends the same get_net()/put_net()
guard to the sunrpc cache files at

 /proc/net/rpc/<cache>/{content,channel,flush} .

Those open helpers had the same hole; sosreport just hit the
nfsd-specific file first because it reads /proc/fs/nfsd/exports.

Patch 5/6's changelog pins down the deref site you asked
about: cache_check_rcu() faults reading h->flags off a
garbage cache_head returned by __cache_seq_start() walking a
cd->hash_table that cache_destroy_net() already freed. Not a
dentry deref. The dentry-teardown path is a separate failure
mode that 48db892356d6 closed for the export and expkey caches.


>> To prevent the
>> issue described in commit 69d803c40ede, should we consider reverting
>> commit 48db892356d6 first?

Not for this series. Patches 3/6 and 4/6 don't add any new
path_put deferral; their commit messages call them out as
consistency changes, not bug fixes. ip_map holds only an
auth_domain reference and unix_gid holds only a group_info,
so neither cache reaches mntput from the deferred release.
The exportfs-r-then-umount sequence isn't touched by this
series.

The svc_export and svc_expkey path_put deferral lives in
48db892356d6, which is already in v7.0. If the umount window
from 69d803c40ede is still reachable through that commit,
that's a regression in 48db892356d6 and worth a separate
thread.


> Locally, I wrote a stable regression test case. I also reverted to=20
> commit 9189d23b835cec646ba5010db35d1557a77c5857 (which is before commi=
ts=20
> 2862eee078a4 "SUNRPC: make sure cache entry active before cache_show"=20
> and be8f982c369c "nfsd: make sure exp active before svc_export_show").=20
> Even then, a panic can still be triggered without any actual export pa=
th...

That fits 5/6's failure mode. Without an export no svc_export
or svc_expkey entry is populated, but rpc.mountd reads
auth.unix.ip/content and auth.unix.gid/content directly,
and on a pre-5/6 tree the open helpers in cache.c hold no
reference on cd->net. cache_destroy_net() at namespace exit
then races a reader still inside cache_seq_start_rcu(), and
the reader walks a freed cd->hash_table.                                =
                                                                        =
                      =20

Could you share the reproducer and the panic stack trace?
If the fault is in cache_check_rcu() through one of the
sunrpc cache files, that confirms 5/6 is the right fix, and
I'll happily carry your Tested-by on it.


--=20
Chuck Lever

