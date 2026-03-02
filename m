Return-Path: <linux-nfs+bounces-19636-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPG2HwUhpmlQKwAAu9opvQ
	(envelope-from <linux-nfs+bounces-19636-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 00:45:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF311E6C8F
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 00:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29AF2301A2CF
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980B8343207;
	Mon,  2 Mar 2026 23:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jlohau7m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCA34167B
	for <linux-nfs@vger.kernel.org>; Mon,  2 Mar 2026 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495106; cv=pass; b=JH1UK4sIyZ88/FO3zBAJ/fZVKvNzWLjAyEAFwStkXzggTOSNVBQKYidM0JimBH0fzlNfu3hdgCU6c+tdnCuDx0Ns84DoZnsJD+adjJyJ2JwSSurJSF6IY3MDPiUVEMp0x/sWLfc2hHF6fLf85CuCW16y9qymHfsNcs4ctXomMwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495106; c=relaxed/simple;
	bh=gI6mzU+h6MF7rNPJ4817XIF1lxMBARF2p+anpiUg0wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJlA04e/oeCN8cLucV+FBpjZhZAbL0WmDRrEFxSyScb5b1j80K2qtYqQbCIDhv07PqszNhAQoSKSBXA59JKgjvqXnr9ENeTArJtk6z06U2YNRgsosocFmaUMrvX96QVJIrTpkDaPOPHbhTYohfjQErqEMo+Tsw2KP2ADs9HLseU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jlohau7m; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2934312a91.1
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2026 15:45:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772495103; cv=none;
        d=google.com; s=arc-20240605;
        b=GMZxi8YlkK5sWBHdkFaOifXslTytkvi1UhIe9l9wk/xVK+61CASIMXMrAZ47lb6WNl
         R89SMQ+FnInv2MVzWWFW4v7UChr5mw9lZfbQWzPcyQ9uaO4ScUrbFDHaB7tDk0KyFJkr
         6yVTMaEbdeph++9OeXRXs9RdmNX7xLMasnJoBu/g1lL8IvzP46WBOUJjYWCr7UllqPGt
         pSh19BsgvscQHc3A/O6nftnB6/S7Mi2J6rtZdM3yOecnggtej9pjk/EbXfMO2qRYkPvi
         RDqo7MJuSQOipcUSvA87/n0N5ae/GiStFQsIG1iZ++AP2nHxMou1L+lQGGZslznDsSou
         6/fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u082M2vpZx7MrZkmV/F7ZdAH+CJQSjxHglDjea1+awA=;
        fh=zfTEJM6Ivkj+sQFVSJ22mPrW1T1YPHKj+BthnWYAaYs=;
        b=J9BcqIrkpzDfICFpaiXrTTr3xlqgkSeftFrXgBY/E8wPRjC3afJtbRneG9aP2cMmCH
         AYO9rtSjMmExZOMU4TYmgzgX4iypLEuq/bY38KJ/b0+wFlRcEGdcXAitSGMjns9ji8yk
         gOtOR0qeYK7Vk7SXetOMPrk9mkN8ckxBeTJ1upjTBkzN2I8hK+AvuYMIbTX0/y1R/scf
         0uj/kBcfQRq2RO54rk2ECa9REEzPS7DvlGcqjZOCdMZBZ5vvh82ZRdGsdoCl38W15dPg
         iFErAEB8cYKJ3ybNnWSgOmDjT62j5iTFuW4eVw46KuFh8aBAR6vlXHHrZ/WA0YZR7Z4n
         CD9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772495103; x=1773099903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u082M2vpZx7MrZkmV/F7ZdAH+CJQSjxHglDjea1+awA=;
        b=Jlohau7m2sNM8GDzyvqU0a0nTQuf+qu3cuCrmzz+AyGIWXH4qCokGvv5cpbrkijbZ8
         WRwHFHj16LfTWXlm4WMp2oskushe2aU51Uf7iEueAYb6Sf/iKTWkVDV0yWPIhOTx5azz
         wqKhHTD6zu6NK3iV9QENRuadm6NkylGySmoWALotgY0ISXxjFj3wo67dI2BlvAkRV5XI
         ZG+JJTzsKRSqI6u414/leBczUk5iRfk5XanaLpsPgJXqPgS32lVIvQ1ORDilRKNbPL56
         zMkNc4huJ1L0FnaFxSjIE56/MA83Mo4T1IgNkG8jcxE29WJVn/oMGzZv9kp5nJLzeDQi
         pIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772495103; x=1773099903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u082M2vpZx7MrZkmV/F7ZdAH+CJQSjxHglDjea1+awA=;
        b=RpNSyvCnawKv2+UWXjPRgH+ADMcFyuY0wNqeJBr8Zv1vaAv9gm/zASx2lTVPQ/ntbW
         z7P2JZ4CQCZ8ixTk+g+eURkgjDtweaBhVyDM0ZtvisBWjiWQG2Zu1R9E4h+zkTYn2hhq
         HWIEBZL9GhsQuECqG+rPXe+SacLco1fOprtWftURU3J0SPkgooAKgTl/56KGf79YDIpg
         0mFleyz3+4Ar/uEHVFmCY2sfCWQAhkmbFkqFAMIOtk9bdzMi6jXbU1YDw9uAmy2srXaC
         kHOVAX1HwSyn8i/d0r6Abfz23hoFJiX53IIi5U7/JVeaMgR+xrf3Vl91+g4vRyauGgz9
         2H2A==
X-Forwarded-Encrypted: i=1; AJvYcCU216W+S0/1NAE0zt8iU0IJlY+ns0qcN0IjRT5cTfPiAqhpvMnUZUpX+X7OqwqjddH6jyhUWii34C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIbaVkygtWhxQENAs4SLfDHD4X+KbUB5QfFtW81Ahx61rYwhq
	yUO8hMFbvAxpZ65IANElG6cg6AwgGSgyO3cr7IwZI/WOjMZ0itQlBNvJRXGWoDE8Te08envmCk5
	2SJwGecb9KZUM95BmFvzffKOl6nenySX7UUVYiGtD
X-Gm-Gg: ATEYQzyzW4ihoNLCr8Pbs0DVw6QUuoHOSlH737+TsIDuhtO+nKY8YltajEwcabLqDeh
	xz8D6jFRxBs2KYl5qnFwe3YKEg88l33Y1SpKH2LUCNGoAKFLpa+rD8S7MUpYoBxeOXGuyt7QKd/
	ds+w0a9kqofI+9/xsjcogSfqJOV4lh3s6V05VZ2pklC1BzaLIrPKnFUFaF5ILz57k/1lNq0l01J
	JFQhZgIgU6vbo5A3WdNnIiH9xf7N7eeo9KxE1sRR+fDbuHgs3Gogl73Q+hkyxIaY8NLloVZ9mdU
	RAoeCYQ=
X-Received: by 2002:a17:90b:578e:b0:356:2eff:df05 with SMTP id
 98e67ed59e1d1-35965c9d15dmr12730172a91.16.1772495102745; Mon, 02 Mar 2026
 15:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org> <20260302-iino-u64-v2-3-e5388800dae0@kernel.org>
In-Reply-To: <20260302-iino-u64-v2-3-e5388800dae0@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Mar 2026 18:44:51 -0500
X-Gm-Features: AaiRm51Sffi2V1GbWbKQK3xjBHaGrjaqO3h4_HvI_INFaL56ZEFyr07E1_3tePs
Message-ID: <CAHC9VhRnmBuXEKkUPQhJ_LDzcksjoAJL-ne6mFoJdR1hnDdzsg@mail.gmail.com>
Subject: Re: [PATCH v2 003/110] audit: widen ino fields to u64
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Alexander Aring <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-x25@vger.kernel.org, audit@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1BF311E6C8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de,yaina.de,holtmann.org,hartkopp.net,pengutronix.de,secunet.com,gondor.apana.org.au,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev,kvack.org,lists.sourceforge.net,lists.samba.org,lists.infradead.org,coda.cs.cmu.edu,lists.orangefs.org,lists.ubuntu.com,lists.freedesktop.org,lists.linaro.org];
	TAGGED_FROM(0.00)[bounces-19636-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[171];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:url]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 3:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> inode->i_ino is being widened from unsigned long to u64. The audit
> subsystem uses unsigned long ino in struct fields, function parameters,
> and local variables that store inode numbers from arbitrary filesystems.
> On 32-bit platforms this truncates inode numbers that exceed 32 bits,
> which will cause incorrect audit log entries and broken watch/mark
> comparisons.
>
> Widen all audit ino fields, parameters, and locals to u64, and update
> the inode format string from %lu to %llu to match.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/audit.h   | 2 +-
>  kernel/audit.h          | 9 ++++-----
>  kernel/audit_fsnotify.c | 4 ++--
>  kernel/audit_watch.c    | 8 ++++----
>  kernel/auditsc.c        | 2 +-
>  5 files changed, 12 insertions(+), 13 deletions(-)

We should also update audit_hash_ino() in kernel/audit.h.  It is a
*very* basic hash function, so I think leaving the function as-is and
just changing the inode parameter from u32 to u64 should be fine.

--=20
paul-moore.com

