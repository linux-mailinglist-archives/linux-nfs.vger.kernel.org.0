Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E4C619667
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 13:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKDMoS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKDMoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 08:44:17 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00776258
        for <linux-nfs@vger.kernel.org>; Fri,  4 Nov 2022 05:44:14 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id w10so3096901qvr.3
        for <linux-nfs@vger.kernel.org>; Fri, 04 Nov 2022 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUFs8GDCWw70O9rcvhyywnjleI5P8AHUP1GW12c+wKk=;
        b=Ts75z9jzQHJA+K8D4nXP2OWvaXWEgeqfHlTc7vY1xIS4CO7P1nKmpPrXGHnV6LRNpX
         3BARxRZWcnv6WCn3eMvrccj1ASb3+YACnIUpVv5+xafk2dmSHsEQCAY2FReZvMc3PKfR
         yXfNc3xQMr//vMoE7LWOmFrI6G6zm6AASDk4CaL/3Yw9Ljlpd+r8Od6cTBV0pZ1gn9EZ
         Ba6I4Rn4tlxl8PBI3QGcuESvmE/Vepb7WQIqVsHR9VQdg5djOntLps6hkE9niMzWZa/T
         yvRw4IB1rSWGisyJ/7Lc81FpCNdHibsTGe2F/0mrOwpEDEbd4hwqzkMcjHNre+eK07Zl
         Z7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUFs8GDCWw70O9rcvhyywnjleI5P8AHUP1GW12c+wKk=;
        b=IqRQ1MJqwnO7v626UnCSvAfExsKy/HWl3PaRXsClrNOx5DA3ucvF8jNNT+4zGrSdJG
         NaPwRo89GXW9BU674GTTNYOCNjUJ/4giC+utdlE9zO9jZ8ooRaQLeX4r0NNKe0xqIKr5
         7dGeoTwHXweqZJZBiT0FLN9hI90RS2R5k6QJrJ/ev69digmVL/5da8sjrSYFHbNNxdbF
         0Ps3etLRBzy3E768wv0LmF0U6iqs5kDii+8UHMaDYeOZ37h3RApQAKZUyEBpuCChQ+Xk
         Ww12SopbXJLo4Fs74ohPaBvYWSQ2PvQ//layV8rpv5/oG6qpW55jCJTJoMyuylV+yyBB
         N67g==
X-Gm-Message-State: ACrzQf3BE0fxrHXzOptK3qsevCymk38xulhGAwFOYhVjOMtAwyhEnWUv
        Fs2DMo2Z2FqVmS9sQ5Jwm09FucfZp6QBsg==
X-Google-Smtp-Source: AMsMyM4AQvI6cWiZum8M/fUunzTPeSu07a2uV0bJ3bAXInrrVDZso9ZUzA0aJv+cTtmnJtqqSuBdIQ==
X-Received: by 2002:a05:6214:1d2e:b0:4bc:22fd:6783 with SMTP id f14-20020a0562141d2e00b004bc22fd6783mr12320393qvd.101.1667565853977;
        Fri, 04 Nov 2022 05:44:13 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a16a800b006ed30a8fb21sm2774497qkj.76.2022.11.04.05.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 05:44:13 -0700 (PDT)
Message-ID: <f2118a51b3ee47de1482081f88ae773c34606b2d.camel@poochiereds.net>
Subject: Re: [PATCH v1 2/2] NFSD: Re-arrange file_close_inode tracepoints
From:   Jeff Layton <jlayton@poochiereds.net>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Fri, 04 Nov 2022 08:44:12 -0400
In-Reply-To: <166750697425.1646.11770177003223505657.stgit@klimt.1015granger.net>
References: <166750689663.1646.10478083854261038468.stgit@klimt.1015granger.net>
         <166750697425.1646.11770177003223505657.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-11-03 at 16:22 -0400, Chuck Lever wrote:
> Now that we have trace_nfsd_file_closing, all we really need to
> capture is when an external caller has requested a close/sync.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c |   17 ++++++-----------
>  fs/nfsd/trace.h     |   45 ++++++++++++++++-----------------------------
>  2 files changed, 22 insertions(+), 40 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index cf1a8f1d1349..7be62af4bfb7 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -706,14 +706,13 @@ static struct shrinker	nfsd_file_shrinker =3D {
>   * The nfsd_file objects on the list will be unhashed, and each will hav=
e a
>   * reference taken.
>   */
> -static unsigned int
> +static void
>  __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
>  {
>  	struct nfsd_file_lookup_key key =3D {
>  		.type	=3D NFSD_FILE_KEY_INODE,
>  		.inode	=3D inode,
>  	};
> -	unsigned int count =3D 0;
>  	struct nfsd_file *nf;
> =20
>  	rcu_read_lock();
> @@ -723,11 +722,9 @@ __nfsd_file_close_inode(struct inode *inode, struct =
list_head *dispose)
>  		if (!nf)
>  			break;
> =20
> -		if (nfsd_file_unhash_and_queue(nf, dispose))
> -			count++;
> +		nfsd_file_unhash_and_queue(nf, dispose);
>  	} while (1);
>  	rcu_read_unlock();
> -	return count;
>  }
> =20
>  /**
> @@ -742,11 +739,9 @@ static void
>  nfsd_file_close_inode(struct inode *inode)
>  {
>  	struct nfsd_file *nf, *tmp;
> -	unsigned int count;
>  	LIST_HEAD(dispose);
> =20
> -	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode(inode, count);
> +	__nfsd_file_close_inode(inode, &dispose);
>  	list_for_each_entry_safe(nf, tmp, &dispose, nf_lru) {
>  		trace_nfsd_file_closing(nf);
>  		if (!refcount_dec_and_test(&nf->nf_ref))
> @@ -765,11 +760,11 @@ void
>  nfsd_file_close_inode_sync(struct inode *inode)
>  {
>  	struct nfsd_file *nf;
> -	unsigned int count;
>  	LIST_HEAD(dispose);
> =20
> -	count =3D __nfsd_file_close_inode(inode, &dispose);
> -	trace_nfsd_file_close_inode(inode, count);
> +	trace_nfsd_file_close(inode);

With this change we lose the count of entries on the list. That info is
not particularly helpful, but maybe we ought to consider a tracepoint in
unhash_and_queue that records whether a file we found in the hash got
queued? It might be nice to have a way to detect cases where we close a
nfsd_file but the refcount was >1 or 0, so we don't end up queueing it
to the list.

> +
> +	__nfsd_file_close_inode(inode, &dispose);
>  	while (!list_empty(&dispose)) {
>  		nf =3D list_first_entry(&dispose, struct nfsd_file, nf_lru);
>  		list_del_init(&nf->nf_lru);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index e41007807b7e..ef01ecd3eec6 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -1099,35 +1099,6 @@ TRACE_EVENT(nfsd_file_open,
>  		__entry->nf_file)
>  )
> =20
> -DECLARE_EVENT_CLASS(nfsd_file_search_class,
> -	TP_PROTO(
> -		const struct inode *inode,
> -		unsigned int count
> -	),
> -	TP_ARGS(inode, count),
> -	TP_STRUCT__entry(
> -		__field(const struct inode *, inode)
> -		__field(unsigned int, count)
> -	),
> -	TP_fast_assign(
> -		__entry->inode =3D inode;
> -		__entry->count =3D count;
> -	),
> -	TP_printk("inode=3D%p count=3D%u",
> -		__entry->inode, __entry->count)
> -);
> -
> -#define DEFINE_NFSD_FILE_SEARCH_EVENT(name)				\
> -DEFINE_EVENT(nfsd_file_search_class, name,				\
> -	TP_PROTO(							\
> -		const struct inode *inode,				\
> -		unsigned int count					\
> -	),								\
> -	TP_ARGS(inode, count))
> -
> -DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode_sync);
> -DEFINE_NFSD_FILE_SEARCH_EVENT(nfsd_file_close_inode);
> -
>  TRACE_EVENT(nfsd_file_is_cached,
>  	TP_PROTO(
>  		const struct inode *inode,
> @@ -1238,6 +1209,22 @@ DEFINE_EVENT(nfsd_file_lruwalk_class, name,				\
>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_gc_removed);
>  DEFINE_NFSD_FILE_LRUWALK_EVENT(nfsd_file_shrinker_removed);
> =20
> +TRACE_EVENT(nfsd_file_close,
> +	TP_PROTO(
> +		const struct inode *inode
> +	),
> +	TP_ARGS(inode),
> +	TP_STRUCT__entry(
> +		__field(const void *, inode)
> +	),
> +	TP_fast_assign(
> +		__entry->inode =3D inode;
> +	),
> +	TP_printk("inode=3D%p",
> +		__entry->inode
> +	)
> +);
> +
>  TRACE_EVENT(nfsd_file_fsync,
>  	TP_PROTO(
>  		const struct nfsd_file *nf,
>=20
>=20

--=20
Jeff Layton <jlayton@poochiereds.net>
