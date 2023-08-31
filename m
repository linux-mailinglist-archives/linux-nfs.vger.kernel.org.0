Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE45478F03A
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbjHaPZA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 11:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjHaPZA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 11:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D94310E2
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693495403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lOqPGeum2Ohan2O+TXrCHEtxJJw1aqkd7sF483hiKc=;
        b=hG8/3fJfgt2M7Ddr5tRR7idi0RiaueGXndvk2QOTaZZjTdHnp9VzKtkUvNpIDM2Sz4K9jK
        SGeAp2KrsZoj7rf4NarlqIg4Dtf8u4MLV1i+XYkDhldbN1xc5ACFxYJt0QZ9qEQtqok92E
        yF23F5COIytzBzkS35Ryk/UtYy2bhsA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-_2dcHVdvN2eC1EaSqY032w-1; Thu, 31 Aug 2023 11:23:22 -0400
X-MC-Unique: _2dcHVdvN2eC1EaSqY032w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B05EB381181F
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 15:23:21 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63A032166B25
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 15:23:21 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSv4: add sysctl for setting READDIR attrs
Date:   Thu, 31 Aug 2023 11:23:20 -0400
Message-ID: <6F5072E7-2C66-4B17-847E-0AA95ED827B0@redhat.com>
In-Reply-To: <8f752f70daf73016e20c49508f825e8c2c94f5e7.1693494824.git.bcodding@redhat.com>
References: <8f752f70daf73016e20c49508f825e8c2c94f5e7.1693494824.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 31 Aug 2023, at 11:15, Benjamin Coddington wrote:

> Expose a knob in sysfs to set the READDIR requested attributes for a
> non-plus READDIR request.  This allows installations another option for=

> tuning READDIR on v4.  Further work is needed to detect whether enough
> attributes are being returned to also prime the dcache.
>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/client.c           |  2 ++
>  fs/nfs/nfs4client.c       |  3 ++
>  fs/nfs/nfs4proc.c         |  1 +
>  fs/nfs/nfs4xdr.c          |  7 ++---
>  fs/nfs/sysfs.c            | 58 +++++++++++++++++++++++++++++++++++++++=

>  include/linux/nfs_fs_sb.h |  1 +
>  include/linux/nfs_xdr.h   |  1 +
>  7 files changed, 69 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index e4c5f193ed5e..cf23a7c54bf1 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -920,6 +920,8 @@ void nfs_server_copy_userdata(struct nfs_server *ta=
rget, struct nfs_server *sour
>  	target->options =3D source->options;
>  	target->auth_info =3D source->auth_info;
>  	target->port =3D source->port;
> +	memcpy(target->readdir_attrs, source->readdir_attrs,
> +			sizeof(target->readdir_attrs));
>  }
>  EXPORT_SYMBOL_GPL(nfs_server_copy_userdata);
>
> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
> index d9114a754db7..ba1dffdd25eb 100644
> --- a/fs/nfs/nfs4client.c
> +++ b/fs/nfs/nfs4client.c
> @@ -1108,6 +1108,9 @@ static int nfs4_server_common_setup(struct nfs_se=
rver *server,
>
>  	nfs4_server_set_init_caps(server);
>
> +	server->readdir_attrs[0] =3D FATTR4_WORD0_RDATTR_ERROR;
> +	server->readdir_attrs[1] =3D FATTR4_WORD1_MOUNTED_ON_FILEID;
> +
>  	/* Probe the root fh to retrieve its FSID and filehandle */
>  	error =3D nfs4_get_rootfh(server, mntfh, auth_probe);
>  	if (error < 0)
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 832fa226b8f2..12cc9e972f36 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -5109,6 +5109,7 @@ static int _nfs4_proc_readdir(struct nfs_readdir_=
arg *nr_arg,
>  		.pgbase =3D 0,
>  		.count =3D nr_arg->page_len,
>  		.plus =3D nr_arg->plus,
> +		.server =3D server,
>  	};
>  	struct nfs4_readdir_res res;
>  	struct rpc_message msg =3D {
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index deec76cf5afe..1825e3eeb34b 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1601,16 +1601,15 @@ static void encode_read(struct xdr_stream *xdr,=
 const struct nfs_pgio_args *args
>
>  static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_r=
eaddir_arg *readdir, struct rpc_rqst *req, struct compound_hdr *hdr)
>  {
> -	uint32_t attrs[3] =3D {
> -		FATTR4_WORD0_RDATTR_ERROR,
> -		FATTR4_WORD1_MOUNTED_ON_FILEID,
> -	};
> +	uint32_t attrs[3];
>  	uint32_t dircount =3D readdir->count;
>  	uint32_t maxcount =3D readdir->count;
>  	__be32 *p, verf[2];
>  	uint32_t attrlen =3D 0;
>  	unsigned int i;
>
> +	memcpy(attrs, readdir->server->readdir_attrs, sizeof(attrs));
> +
>  	if (readdir->plus) {
>  		attrs[0] |=3D FATTR4_WORD0_TYPE|FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZ=
E|
>  			FATTR4_WORD0_FSID|FATTR4_WORD0_FILEHANDLE|FATTR4_WORD0_FILEID;
> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
> index bf378ecd5d9f..6bded395df18 100644
> --- a/fs/nfs/sysfs.c
> +++ b/fs/nfs/sysfs.c
> @@ -270,7 +270,59 @@ shutdown_store(struct kobject *kobj, struct kobj_a=
ttribute *attr,
>  	return count;
>  }
>
> +static ssize_t
> +v4_readdir_attrs_show(struct kobject *kobj, struct kobj_attribute *att=
r,
> +				char *buf)
> +{
> +	struct nfs_server *server;
> +	server =3D container_of(kobj, struct nfs_server, kobj);
> +
> +	return sysfs_emit(buf, "0x%x 0x%x 0x%x\n",
> +			server->readdir_attrs[0],
> +			server->readdir_attrs[1],
> +			server->readdir_attrs[2]);
> +}
> +
> +static ssize_t
> +v4_readdir_attrs_store(struct kobject *kobj, struct kobj_attribute *at=
tr,
> +				const char *buf, size_t count)
> +{
> +	struct nfs_server *server;
> +	u32 attrs[3];
> +	char p[24], *v;
> +	size_t token =3D 0;
> +	int i;
> +
> +	if (count > 24)
> +		return -EINVAL;
> +
> +	v =3D strncpy(p, buf, count);
> +
> +	for (i =3D 0; i < 3; i++) {
> +		token +=3D strcspn(v, " ") + 1;
> +		if (token > 22)
> +			return -EINVAL;
> +
> +		p[token - 1] =3D '\0';
> +		if (kstrtoint(v, 0, &attrs[i]))
> +			return -EINVAL;
> +		v =3D &p[token];
> +	}
> +
> +	server =3D container_of(kobj, struct nfs_server, kobj);
> +
> +	if (attrs[0])
> +		server->readdir_attrs[0] =3D attrs[0];
> +	if (attrs[1])
> +		server->readdir_attrs[1] =3D attrs[1];
> +	if (attrs[2])
> +		server->readdir_attrs[2] =3D attrs[2];

Eh, this ^^ is obviously wrong - we want to allow setting to 0.  I will f=
ix
this if there's interest.

Ben

