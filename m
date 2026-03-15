Return-Path: <linux-nfs+bounces-20175-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fLiPE7l/tmkvCgEAu9opvQ
	(envelope-from <linux-nfs+bounces-20175-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 10:45:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC5C290593
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 10:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0B5D3053A72
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Mar 2026 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E97245031;
	Sun, 15 Mar 2026 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTSdZngq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213E223DD6
	for <linux-nfs@vger.kernel.org>; Sun, 15 Mar 2026 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773567925; cv=pass; b=VIEFx0dnhhlO6RAUAyfE8IBmnAOx8q5B9PhPVPpPQHDC7+q+Iyk4hsipTMEypPJ0FYruT+U579M249xez9VulR46elw8tcsyyqYiMAzaPTGhwGix1UiimKJz2zRLOOBOE0aDlQ4iobly60udl7QkgSoyYROFBPDh15u0NyJ/E0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773567925; c=relaxed/simple;
	bh=gEKJYkbQ4JlzsaY9SkiTQe6HstO1aAeHW7fmZyAiD60=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eLihFlAlPS6iIRyVVDFqcWhC87fT9+jOxpS2o5ReyA28NzyihTgIIUMQjLCXli/2ngz2NP2aLXLC8wYPal5L7WL0n11at6tgCBLrRbDpTkrRaV/w1xGiwFuKXN02ZFdSVKeTNHxpw/l/TMclp6yRWl5WQHhLUDvkcX+72Ejmyi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTSdZngq; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b976536806cso392958866b.0
        for <linux-nfs@vger.kernel.org>; Sun, 15 Mar 2026 02:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773567922; cv=none;
        d=google.com; s=arc-20240605;
        b=JwqCVxLcn98LuEkgV0MA6kA9PMnrwwd+Q6EN7RoKlwxjs5GSOTMFUFjBl+3Cy1VSRv
         SlqtIxqx0egN3oYRZAq0CD06Vs+5WqhMklvmTJuZVUEJVivGJzUitAu1Nj6MVHBeQKgp
         Vc2bLiA4brsJsOV1HySqv1fXNY7qDtz5Dn9xaItbSepbLuCpS1DaCLKJsS7cy+CBBHPo
         5Ih6+y7VOYNm77L37X5Irvf6vRYKiV9u56LC8tI9EveR9F5ptz12sUiufl/K1m9HQUJ2
         2sZk0QSb+7thrZHOGwBZ/TXQ3d2xzo5Hb6GkUzzY1Obbk4+5z5ieXbLRv83eOearlb6n
         zK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=gEKJYkbQ4JlzsaY9SkiTQe6HstO1aAeHW7fmZyAiD60=;
        fh=A3pMOUK00huGibGCZBFsLekFLVbB5hHGKjUNNKwO+5E=;
        b=TbjWnH5MSdTEqm/s2eMNukbEoW70liTryWvtb0ab82N1jz0yK3pQI9LuDyilZSdpH2
         6Zxe0yJFFmzLRhWJKP9u3HNLx67/we30qyjjSgpQLWhMujlpi0kKChJOZVc6uEKx4tZy
         l0P2MlSftzw6EJs9XjkRQnksUVrKG1qz+p0xJlvcdZaTmieVVTXdhox20vUHvcEa/ov9
         G2b8psadzuRkoDOtt2Q9BI60pNziRyOqIHxld1KMp9y4e8lwwojoxVFUcRudrqOLn/n+
         bApAl7V1qF6lvFfH843eSmAsDa1P/e5toap+jVoU5khhwSq/M/2RGKEgtre3DVvuIVzP
         UT7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773567922; x=1774172722; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gEKJYkbQ4JlzsaY9SkiTQe6HstO1aAeHW7fmZyAiD60=;
        b=dTSdZngqjKULZYo4j8IipAw7cYwfBHXr6BPLAcUX3Dp6CC4NW0qX+Yl5PbDdJ2cJU+
         aZtSNMWojHWYzl1Eq2UWct1A//niDiJ6ioEPe/pYYqsABQZTScfYEKx+fJ4LM0b3guBd
         710UyDcIuoLxOQ2/p2zxw18uumuZyVdyBjO2v3PAVUzhJLvlD75xfQOklFKXDDp/KS9M
         JIoPTCMW2o+stiQ+QpUnSJcGwcn1vmU2Na42snptrMMdG5XRcrUg6zSlLm9duYqb54Ur
         pnNSFltrem2Q7J5MILzX1f5V9NE2y8U6zpwePx2U7XX10QDTVUKBHceaU3fyviXJ+n1E
         s9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773567922; x=1774172722;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEKJYkbQ4JlzsaY9SkiTQe6HstO1aAeHW7fmZyAiD60=;
        b=c00AgiJthGT9u5pfwpaTzuPnyV1/mNB+9x7nP3cCuXJ7pXXo5OpTWeaEbbL/aa2m+F
         0+FoWwICitrtKy8cto7PUtBD08DXnqfkQdm/4JzUqk/dIOQ2/OjC4JMPe5eWGegqkNwH
         AWopyiYrg/xCOt3lieqngLFnZ/Up2wG/ZkQmveK+Jk9U2I16G8p8SXIq8h57dCWZKFwZ
         PcAIYjIAhWc2q7/ILz7OzkSusqXF1IoEo6E4CBBUriqlsHr/fpTa63KwQ9q6YmpraW6f
         RIApFyAVEGg6ClD3ihfqVYTNHGY6BJhiZSwSW/CknioUzmVCH1BYOQmO3OYbR8jcA57h
         TCYg==
X-Gm-Message-State: AOJu0Yxe7Cd8CW+60c5JY4d66skodZ+vzE1jtFWq2xgmqaI67DUWOv2Z
	2oWsUCikzmSls80T9ZGlov0Jwa4vBBq9FfJ/3w+4J8j1gIqq+mhRNDdGu1gh//QHvveZx+0ygaS
	e/RoojTF9GWhwT37muJ8nDikZ0MgNUzCiu1UDgmM=
X-Gm-Gg: ATEYQzy9LctNbUJgtGEU1g8alOg5qV+qWiaGQtrjeKi3hwof2MSGgdVD3E3NXwCslNZ
	omRF5d1rc3HPpaOCiFsOcJbvta5sJQwC9Nt/ovvYeT5+uslxF54WgX6zacWo69GAtoaqri1hvQz
	SXcIs1mIqrj/y+J7KS65JZsToCZ0ngV7i09InS3tiowiy4SFYLiaLF1A79s09JsLm+Z9s/M/EXK
	uvUBIE0H92aVq4N9iixBVodbn5ljRqdUg2I0xP0qINf3RrvS6So9y3RcezhG7BooNaC2UkrfqOB
	mblVewczQLaY7YFaGVV8Y8eGcy1odjZl+3ZOAOI=
X-Received: by 2002:a17:907:3f05:b0:b97:7d03:68c1 with SMTP id
 a640c23a62f3a-b977d0371e2mr319668966b.30.1773567921820; Sun, 15 Mar 2026
 02:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Sun, 15 Mar 2026 10:45:00 +0100
X-Gm-Features: AaiRm51WWBAgqKX0zrvzY3ztNiq8JEW6TYkpgoBjdMuLP7VUQLUFP_f5x8GjnWg
Message-ID: <CA+1jF5pnVrOOum0=t_Yf3QFmhRdFZOmWtRs0iZ+3Z2xt18EELw@mail.gmail.com>
Subject: How to add Linux users/groups with whitespaces in the name, so NFSv4
 and SAMBA can use them?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20175-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aureliencouderc2002@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CEC5C290593
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both SAMBA and NFSv4 have to deal with user and group names with
<space> in their strings.
Common example is the Windows/OSX "Domain Users".

Is there any solution in Linux useradd/groupadd to add such groups and
users for NFSv4 or SMB?
Because e.g. groupadd group -n 'Domain_Users' -g 2016029 does not work.

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

