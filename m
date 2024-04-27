Return-Path: <linux-nfs+bounces-3044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C508B4514
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Apr 2024 10:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A605282EE4
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Apr 2024 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801AA45009;
	Sat, 27 Apr 2024 08:14:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F644C61
	for <linux-nfs@vger.kernel.org>; Sat, 27 Apr 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714205695; cv=none; b=jNpQFIdE39k4zlucvsGjptoxa3ot8/7b8asDhsKSiMwf23FrJTzFHEW2QBgCK9E/0gBA+4v37hi87/L4qOyEmaidNgBPMOynXFTUF+9o/AB5oDyKTiGDecUNM/aGY0dAI+wFLxdIBHQ1e+qiHKf4DOuxKF5829AGWD+yvYSc5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714205695; c=relaxed/simple;
	bh=yonDWqdlxvIDOh++86MACveVtWv+lfo/zS7623cId9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Dp3n9NWaPR9oDKa9wchVCj/xlTETqxBmzW3+jRdO2zdwa6UgdDBQ+UKG+HDiLje06EoVOcosVUPpYf6a6GyIzkf/pZIFXHzmjYW9MiaXB/dYVy597PosD8qmpYUEQKEj3xeAkEZPzv/TTQVYLok5vkcuvBCd/avL1XRFCKIiPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-ISDaXyS1NyqDVnSv6P_Hvg-1; Sat, 27 Apr 2024 04:14:47 -0400
X-MC-Unique: ISDaXyS1NyqDVnSv6P_Hvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA54D8001B2;
	Sat, 27 Apr 2024 08:14:46 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F3B202450F;
	Sat, 27 Apr 2024 08:14:37 +0000 (UTC)
Date: Sat, 27 Apr 2024 10:14:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Joel Granados <j.granados@samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
	Joerg Reuter <jreuter@yaina.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dccp@vger.kernel.org,
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
	linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	lvs-devel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] ax.25: x.25: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <ZiyxJFnJimaRr9nK@hog>
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
 <20240426-jag-sysctl_remset_net-v5-8-e3b12f6111a6@samsung.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240426-jag-sysctl_remset_net-v5-8-e3b12f6111a6@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-26, 12:47:00 +0200, Joel Granados via B4 Relay wrote:
> diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
> index c4f8adbf8144..8f385d2a7628 100644
> --- a/net/ax25/ax25_ds_timer.c
> +++ b/net/ax25/ax25_ds_timer.c
> @@ -49,12 +49,16 @@ void ax25_ds_del_timer(ax25_dev *ax25_dev)
> =20
>  void ax25_ds_set_timer(ax25_dev *ax25_dev)
>  {
> +#ifdef CONFIG_AX25_DAMA_SLAVE

Is this really needed? Looks like this file is only compiled when this
config is set:

grep ax25_ds_timer net/ax25/Makefile
ax25-$(CONFIG_AX25_DAMA_SLAVE) +=3D ax25_ds_in.o ax25_ds_subr.o ax25_ds_tim=
er.o


>  =09if (ax25_dev =3D=3D NULL)=09=09/* paranoia */
>  =09=09return;
> =20
>  =09ax25_dev->dama.slave_timeout =3D
>  =09=09msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) / 10;
>  =09mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
> +#else
> +=09return;
> +#endif
>  }

--=20
Sabrina


