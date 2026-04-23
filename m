Return-Path: <linux-nfs+bounces-21049-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePIPEtpR6mkhxgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21049-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:07:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300545556F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73EDB3010DB0
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC3D38422A;
	Thu, 23 Apr 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdF1PzMo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726236DA0B
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963711; cv=pass; b=Sq0TGwkTUg13Q9xGmbSnCs+5cYkMfwgG1EaC1nU+QJnuE5yhDe2IaJoFppYDRDYby/EM4SzhlTOa8lUbAycFqHlL3tNBYrEKZ/VIfE2uatGNzQSFgM8KXPIX3RgZsGSg9W2sOCrq9DWlHcyuIecz7UVMUuEA9wrT+xmVjCoiH94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963711; c=relaxed/simple;
	bh=TOn7OaufpVFnTCngKERiD7517EOajGuL0SqpRc86qfg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ec3w0+gVHMev0kGZlCEfP0BQPcnznwfGGPMD6D63VI60CrDkkclSj7WV3jXSXkcjXCLykhy9q0VWJDKy1PXurKVB7Q+tRZYmvASc8Vf1uOtHIJbUn1ZoR69X/zEZsD4t3bTBqEiFZkMIgx61uUc/PAl7ZfX2fqOtR4fK8vanFxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdF1PzMo; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba36357195bso838945666b.0
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 10:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776963708; cv=none;
        d=google.com; s=arc-20240605;
        b=eX73rTB41CS5ZsTqoNa0I8dqLAwzV4gTnp8/ajKUn6nxscP+DF9c2vJ6OwihAS6+91
         PTOUeJn/KpUjEmnvP+2NUv6i8vxmEmYNLdvGCajpOcO4p3lJzm4bYDrZVv3QRZEm+iZP
         krEoegAIZ8IWR52GJwPjfCRzel2o1b9Wqjzmu1QswBkS+YuldwuFHNCl5ZPINK1kAcbS
         ADBdwsmyhwtHzKuDQ/+v2mZeqVLA8GiuHaSQ/PxZpYZTRDujvFMabU9TNQWuWN0t+YaY
         WC9GGM3Bdm6DWWjp4MZfTkTANuNb3tMMq/mn5zBeq+mubMCd4HavZaVXa74eYE2RSX8c
         wJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MR7Evo27Fb9n4uesCJvxrzmJyEK/vZpzgb8CmAsEAsY=;
        fh=gHT4H9sPsZG/Cm2oJVlyB5NQcP7AL4XFsXHzwtd4CGA=;
        b=CUVVPVNxYK0J7olFiYz6ohueNKR4z5xLKY/LWNEjcipZxGxCSWE1wL7rxv0PZMZlM1
         OJMx0gp4aeF3fwB4JC7mcEGMiU831kVlzb+jX9ltX9jvWkGHqwCylaMLTP+nkLfbDp1E
         bb9Aiwo2vDdpRFy9BJ9gHUtcU07GHP+zlDvFabI8pWvUgz1DfqVX3tg6BNpzV//AUWv+
         +gy1Sv+49SQ27ZDA3nbubjC2xxK7c9veSkgQ9i/JyAvudZIGwYec5KryMvW9hH3EG1f1
         ZQXA5kYjKVJch4x05yhP4R8AY20XCjEY7gTzDyR7GpG6Yau4PwTaYL+97XgWfk0kgUgs
         SF9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963708; x=1777568508; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MR7Evo27Fb9n4uesCJvxrzmJyEK/vZpzgb8CmAsEAsY=;
        b=PdF1PzMohNRn0isPMagJx9rrY/oepjF5joKh5Zol1v/7Yubwk47gLSdZK0Czm6GULO
         pLOn93YoBenCX+K400L9WTJ53d+HxTuc2zm630KfpLiFwYOMezczStPEksFaCE1z6aPO
         GSuvd0fJn7TY+bBUZBpFtRejchDJ3gRmkd8Gnsg+r3bVQIMQ3Wqt7WXENsUD8fLck773
         85AWE9chzIs/auTrxMNobZEYiWW+7jy9Tm+sjp3d7LyCr2FSYzJtXATEdG1iFBqlX4O/
         gE06LdyvSzfexIcQqrIw98lxjq1LHNVsO4bWGfVjfEvuhmQ5LYdLUoy8fgFJg1tuF7/3
         bWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963708; x=1777568508;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MR7Evo27Fb9n4uesCJvxrzmJyEK/vZpzgb8CmAsEAsY=;
        b=gH8eiqE7IvkdqYL95ulQ/1hOD5qFxNpmnUD0rNY4JUS5Ec9KSivagrTjLK+akBLkE2
         ChaHLazpU4aMiOeXgmewbEhaUwmTsqlk7SM1XZrThCieWJM6kTtI0z2MDo/tKAw71v8O
         pHMAaRB8UUoAAjSqZXP/UZ3ag/SAUrW3P5ucc6yc9nQEsZVQfwrGI7752/nv/nB/zbtf
         869oI1iPXvSGKeUC5Ug+QnqAm4yRCKoXIN7zGZMZNLMMqFZatogATytFCaVhT2Fb0q09
         TKptIkqy2r4itOeTSxitRjBEiC6mcqxMSdSCnHiZk1XKmZ9WitVsp2ysVjqkuhbLpqfU
         iO+w==
X-Forwarded-Encrypted: i=1; AFNElJ9e6S1AMsyJImJINaWMuzpWjoZmkp8AiNPGqsOU7befiErCM0m380K/F/lPoWuSIV8QoZaiW63npr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDjG6co5dD4B+jbTbcPNh+P2i9WPjHpY5fANYtXLoi+0LGxHe
	P32yUe0v7Vmd5FkdQQgEJLAaJ43Y5tkT0pJ5taM4MGs0EtIP3/qsXeTFoGkm8h/epbhpxMurGWn
	Hg4z+eufpjP7/170Qk79JQv2cwN6fSdE=
X-Gm-Gg: AeBDiesAoaIbwvhkkfpGRx087GrGylHev3a0T93f5cE4YCyvMipp+kmZQucqSXRyw4D
	t4MIRPahZ6SSAaKLQ5bizYW0OQIzLCRV9XByGwa2WDlJU5cNYV4MYYFvU7YXy4IOi7ulR2V1dPR
	27wt4jdhZz6FbalbLdNmhq+FfqnAEft7jRQ4cXR96CAva3lW0cgbwd5IkzeF/08CW/kcVLZH5y3
	ttHk4V3RfLoZVN2G0YCJt/OosD640WeNSvJuBKsnOo+njcnT99c2zfOGRMHd1YXCj+nIs/uAW0W
	+bDZFc/to130mqR5
X-Received: by 2002:a17:907:da7:b0:ba6:4e0f:e396 with SMTP id
 a640c23a62f3a-ba64e0fe8fdmr1021131966b.12.1776963708142; Thu, 23 Apr 2026
 10:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Thu, 23 Apr 2026 22:31:37 +0530
X-Gm-Features: AQROBzAXKGkL4wCrc7a7jqx_RwqEbMziZZLN-r7g3-kQL0OMGl7pH-QpRiQgpWw
Message-ID: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>
Subject: "Intent" of VFS lookups
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21049-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7300545556F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

Wanted to understand if this is a problem for other filesystems or if
it is specific to SMB protocol?
SMB2+ protocol mandate that open call specifies if the file being
opened is a directory or not (regular file).

This means that during the VFS lookup callback, fs/smb/client needs to
first try open as one type, check the return status and then possibly
do the open as the other type.

From SMB client POV, it would have been good to know from VFS lookup
callback if the current dentry is intended to be a leaf or not. This
would enable the SMB client to decide which type of open to make
first.

Or if there is a clever hack that I'm missing here, I'm open to ideas.

-- 
Regards,
Shyam

