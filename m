Return-Path: <linux-nfs+bounces-8766-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA249FC2C3
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 00:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D691643D4
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Dec 2024 23:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06618B463;
	Tue, 24 Dec 2024 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UastsdtV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kEjkYiqJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UastsdtV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kEjkYiqJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B914901B;
	Tue, 24 Dec 2024 23:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735081381; cv=none; b=NmCWEgmaq8eL7DzE0MmQx24dYd/Ls93xdJH5yAlpiOWB2zMRXt4pfZbDmwMRi65hUVUocnimW/3lGdjPqCtj822rUkRm8XorOClsFiH339ZCrlaOrV4xZFvU9zNqXLlDXGlTvFWNOpilg3LrBNVd21Ifs9QPVe23YxBGHjmLt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735081381; c=relaxed/simple;
	bh=Lw4NoN++ZJoMWZiseT3NVt8IBIZGBJWGAzuJtZO4X5E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UcS9hX2KRVNWbFYICAXLCAb2nxBjEGa/qOs2G/O5CFuQpoVXRzeQ5tkWzVC80YgxkHjham2M/0pMb0JT5DpZKFWSTeC3wotylPWZipOjjAJvjbtb/z41MFxnMjANN6JZpHJ7/2RvGazPGAbDNhAlIlEqua6F/GWrrdTHmAFV8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UastsdtV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kEjkYiqJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UastsdtV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kEjkYiqJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88C4420162;
	Tue, 24 Dec 2024 22:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735080851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSc8A8DsyKSICOfIB8T/zZ5Kt+I37ZOAN2GTAyX9U0w=;
	b=UastsdtV/6FP+WH2grVYfhyEbOf2ypcyrIwDTb8Sb8lfq8V3ZSNUidYiQ+oZYOpMVJBavm
	I1FM1CrGu/lW80ZgctuZYaexeRFIWJ7BgAMcu3vr+u2Q4Ffpe6uHdTHplOsRnujB63iQYH
	h6XdxP5p7JILYFMYcHgKgt+Us0IUsdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735080851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSc8A8DsyKSICOfIB8T/zZ5Kt+I37ZOAN2GTAyX9U0w=;
	b=kEjkYiqJghcEiluVgVuJSRzV32Ktk6PZjs1w+C+py6f/xLdm6PmvAGPZNsofVrxfB/jEMs
	LyRa+Gt8CL3uDnCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UastsdtV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kEjkYiqJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735080851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSc8A8DsyKSICOfIB8T/zZ5Kt+I37ZOAN2GTAyX9U0w=;
	b=UastsdtV/6FP+WH2grVYfhyEbOf2ypcyrIwDTb8Sb8lfq8V3ZSNUidYiQ+oZYOpMVJBavm
	I1FM1CrGu/lW80ZgctuZYaexeRFIWJ7BgAMcu3vr+u2Q4Ffpe6uHdTHplOsRnujB63iQYH
	h6XdxP5p7JILYFMYcHgKgt+Us0IUsdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735080851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSc8A8DsyKSICOfIB8T/zZ5Kt+I37ZOAN2GTAyX9U0w=;
	b=kEjkYiqJghcEiluVgVuJSRzV32Ktk6PZjs1w+C+py6f/xLdm6PmvAGPZNsofVrxfB/jEMs
	LyRa+Gt8CL3uDnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A424913999;
	Tue, 24 Dec 2024 22:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jCojFo87a2evVgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 24 Dec 2024 22:54:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Yang Erkun" <yangerkun@huaweicloud.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, yangerkun@huawei.com,
 yangerkun@huaweicloud.com, yi.zhang@huawei.com
Subject: Re: [RFC PATCH 0/5] nfsd/sunrpc: cleanup resource with sync mode
In-reply-to: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
References: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
Date: Wed, 25 Dec 2024 09:53:55 +1100
Message-id: <173508083549.11072.301112272697956815@noble.neil.brown.name>
X-Rspamd-Queue-Id: 88C4420162
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, 17 Dec 2024, Yang Erkun wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> After f8c989a0c89a ("nfsd: release svc_expkey/svc_export with
> rcu_work"), svc_export_put/expkey_put will call path_put with async
> mode. This can lead some unexpected failure:
> 
> mkdir /mnt/sda
> mkfs.xfs -f /dev/sda
> echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
> echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
> exportfs -ra
> service nfs-server start
> mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
> mount /dev/sda /mnt/sda
> touch /mnt1/sda/file
> exportfs -r
> umount /mnt/sda # failed unexcepted
> 
> The touch above will finally call nfsd_cross_mnt, add refcount to mount,
> and then add cache_head. Before this commit, exportfs -r will call
> cache_flush to cleanup all cache_head, and path_put in
> svc_export_put/expkey_put will be finished with sync mode. So, the
> latter umount will always success. However, after this commit, path_put
> will be called with async mode, the latter umount may failed, and if we
> add some delay, umount will success too. Personally I think this bug and
> should be fixed. We first revert before bugfix patch, and then fix the
> original bug with a different way.

Thanks for these patches.  I think they are certainly a better approach
to fixing the problem - well done.

My only thought was that instead of changing how cache_check() works, we
could introduce cache_check_rcu() which doesn't drop the ref.
cache_check() would then just call that then optionally drop the ref.
I'm not convinced that is better, so I'm just mentioning it in case
anyone else wants to agree.  I'm happy for the patch set to be applied
as-is.

 Reviewed-By: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

