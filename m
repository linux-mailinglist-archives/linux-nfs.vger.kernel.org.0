Return-Path: <linux-nfs+bounces-6637-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29ED9853E5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837E82884A6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F9189B81;
	Wed, 25 Sep 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qiDV98Zk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I899RiTW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qiDV98Zk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I899RiTW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F418A6D3
	for <linux-nfs@vger.kernel.org>; Wed, 25 Sep 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727248888; cv=none; b=JgytHYie+6/ChX7psqWcBFdU+Kq2VlX2vXLhk5/fs6Zvu25OTxX3GcJZJhrz+Kj1E9Gfj95jOoslRKn1WqVfOFfA9oeCnUOuQy+RxXCH1+E0zrYZRYjME7e0eY20KNHthcHv7TLXI2JAgYLekdUbyBhmHg2h/gUvDYj30buYTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727248888; c=relaxed/simple;
	bh=fDtQfVVrjeL9qrp+c3fAgo1wXxWkoHKA2lw5V8yPS3g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kZ7yE5CVAL00U/T+QlRAP/Qi2DU8Sl5ZXkXPrt05nHL9swJGcOQkWEonqkFj2wde7pUG/g1NNo+5n5KQ1MRgDLYlzYECn5pDd4CJijvP8k+X3LdxCmCl7c1Flh5NsFNETMBtHqZOTnuTb4Ouoqw2w7kHEtD/GuDGBEY1VZ8drSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qiDV98Zk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I899RiTW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qiDV98Zk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I899RiTW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B12C21A82;
	Wed, 25 Sep 2024 07:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727248884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxhi4T09B6e5ldQeZvuk/npDXor0qS5Pg0b76BhRbvI=;
	b=qiDV98Zkwya8O/GLBo0ZP0+vAhAY12HJBt2Imxtxuvp4D6Zg1nSaqmCAanIL0C1VWidnmG
	7zWg8tfwHT7AcMxPaMuNba5IZtoZWvI9mpLiLU7fmBAr4PHdxE+b7t+aPSjliKp4TYZG1H
	1AZdFT5rqKh67Gw9n1EuNbeF/ossRrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727248884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxhi4T09B6e5ldQeZvuk/npDXor0qS5Pg0b76BhRbvI=;
	b=I899RiTWBnJ6G1G1cCUY6zwJqU7YDQSlVkpsToadog74Pl0A5Tq7M8QzNL8L8NI4AeG2yo
	Av4AQNYsyDjdCRAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727248884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxhi4T09B6e5ldQeZvuk/npDXor0qS5Pg0b76BhRbvI=;
	b=qiDV98Zkwya8O/GLBo0ZP0+vAhAY12HJBt2Imxtxuvp4D6Zg1nSaqmCAanIL0C1VWidnmG
	7zWg8tfwHT7AcMxPaMuNba5IZtoZWvI9mpLiLU7fmBAr4PHdxE+b7t+aPSjliKp4TYZG1H
	1AZdFT5rqKh67Gw9n1EuNbeF/ossRrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727248884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxhi4T09B6e5ldQeZvuk/npDXor0qS5Pg0b76BhRbvI=;
	b=I899RiTWBnJ6G1G1cCUY6zwJqU7YDQSlVkpsToadog74Pl0A5Tq7M8QzNL8L8NI4AeG2yo
	Av4AQNYsyDjdCRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5BED13793;
	Wed, 25 Sep 2024 07:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qQDWFvO582ZybQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 25 Sep 2024 07:21:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [bug report] SUNRPC: replace program list with program array
In-reply-to: <12f691c2-6453-4646-a31a-23d14a610b97@stanley.mountain>
References: <12f691c2-6453-4646-a31a-23d14a610b97@stanley.mountain>
Date: Wed, 25 Sep 2024 17:21:20 +1000
Message-id: <172724888031.17050.16720575629662116950@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 25 Sep 2024, Dan Carpenter wrote:
> Hello NeilBrown,
>=20
> Commit 86ab08beb3f0 ("SUNRPC: replace program list with program
> array") from Sep 5, 2024 (linux-next), leads to the following Smatch
> static checker warning:
>=20
> 	net/sunrpc/svc.c:1368 svc_process_common()
> 	error: uninitialized symbol 'progp'.
>=20
> net/sunrpc/svc.c
>     1320 static int
>     1321 svc_process_common(struct svc_rqst *rqstp)
>     1322 {
>     1323         struct xdr_stream        *xdr =3D &rqstp->rq_res_stream;
>     1324         struct svc_program        *progp;
>     1325         const struct svc_procedure *procp =3D NULL;
>     1326         struct svc_serv                *serv =3D rqstp->rq_server;
>     1327         struct svc_process_info process;
>     1328         enum svc_auth_status        auth_res;
>     1329         unsigned int                aoffset;
>     1330         int                        pr, rc;
>     1331         __be32                        *p;
>     1332=20
>     1333         /* Will be turned off only when NFSv4 Sessions are used */
>     1334         set_bit(RQ_USEDEFERRAL, &rqstp->rq_flags);
>     1335         clear_bit(RQ_DROPME, &rqstp->rq_flags);
>     1336=20
>     1337         /* Construct the first words of the reply: */
>     1338         svcxdr_init_encode(rqstp);
>     1339         xdr_stream_encode_be32(xdr, rqstp->rq_xid);
>     1340         xdr_stream_encode_be32(xdr, rpc_reply);
>     1341=20
>     1342         p =3D xdr_inline_decode(&rqstp->rq_arg_stream, XDR_UNIT * =
4);
>     1343         if (unlikely(!p))
>     1344                 goto err_short_len;
>     1345         if (*p++ !=3D cpu_to_be32(RPC_VERSION))
>     1346                 goto err_bad_rpc;
>     1347=20
>     1348         xdr_stream_encode_be32(xdr, rpc_msg_accepted);
>     1349=20
>     1350         rqstp->rq_prog =3D be32_to_cpup(p++);
>     1351         rqstp->rq_vers =3D be32_to_cpup(p++);
>     1352         rqstp->rq_proc =3D be32_to_cpup(p);
>     1353=20
>     1354         for (pr =3D 0; pr < serv->sv_nprogs; pr++) {
>=20
> This loop used to iterate until we hit a break statement or until progp was=
 NULL
>=20
>     1355                 progp =3D &serv->sv_programs[pr];
>=20
> But now progp is always non-NULL.  (Smatch is concerned that ->sv_nprogrs is
> <=3D 0 but I doubt that's possible?)

It is unsigned so <0 is certainly out, and in practice it is never zero.
But we shouldn't depend on that.

The code is also wrong in that an unknown program number will cause the
last program in the array to be used.

I'll send a patch.

Thanks,
NeilBrown


>=20
>     1356=20
>     1357                 if (rqstp->rq_prog =3D=3D progp->pg_prog)
>     1358                         break;
>     1359         }
>     1360=20
>     1361         /*
>     1362          * Decode auth data, and add verifier to reply buffer.
>     1363          * We do this before anything else in order to get a decent
>     1364          * auth verifier.
>     1365          */
>     1366         auth_res =3D svc_authenticate(rqstp);
>     1367         /* Also give the program a chance to reject this call: */
> --> 1368         if (auth_res =3D=3D SVC_OK && progp)
>                                            ^^^^^
> So this condition doesn't make sense.
>=20
>     1369                 auth_res =3D progp->pg_authenticate(rqstp);
>     1370         trace_svc_authenticate(rqstp, auth_res);
>     1371         switch (auth_res) {
>     1372         case SVC_OK:
>     1373                 break;
>     1374         case SVC_GARBAGE:
>     1375                 goto err_garbage_args;
>     1376         case SVC_SYSERR:
>     1377                 goto err_system_err;
>     1378         case SVC_DENIED:
>     1379                 goto err_bad_auth;
>     1380         case SVC_CLOSE:
>     1381                 goto close;
>     1382         case SVC_DROP:
>     1383                 goto dropit;
>     1384         case SVC_COMPLETE:
>     1385                 goto sendit;
>     1386         default:
>     1387                 pr_warn_once("Unexpected svc_auth_status (%d)\n", =
auth_res);
>     1388                 goto err_system_err;
>     1389         }
>     1390=20
>     1391         if (progp =3D=3D NULL)
>                      ^^^^^^^^^^^^^
> Same
>=20
>     1392                 goto err_bad_prog;
>     1393=20
>     1394         switch (progp->pg_init_request(rqstp, progp, &process)) {
>     1395         case rpc_success:
>     1396                 break;
>     1397         case rpc_prog_unavail:
>     1398                 goto err_bad_prog;
>     1399         case rpc_prog_mismatch:
>=20
> regards,
> dan carpenter
>=20


