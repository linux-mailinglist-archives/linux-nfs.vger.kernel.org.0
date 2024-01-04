Return-Path: <linux-nfs+bounces-932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DFC824411
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB3B1F21EB1
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E122EE0;
	Thu,  4 Jan 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZouwQajw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9x0hu6J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZouwQajw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9x0hu6J";
	dkim=permerror (0-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKXnxee8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A122F0E
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23BDD1F815;
	Thu,  4 Jan 2024 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704379589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=xpHPHiueK5SWy5nP1Oy4tS+P13aSnoK/MN6P2Bmql5w=;
	b=ZouwQajwJMnrTGsnXCchidw63GS2zAdH9Oq5FzakWhzcu/qOnwVOtGd7UAN5mnOhzYwuWZ
	as5VWZbvD/ZOu2G00EIqqhb/Qa4KkLTy1h1Es0KsZlw0uk+/bereppArf8b0uoW/3GVoRQ
	RXSkpX9AQaihNne3vqNuutstVBjTb5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704379589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=xpHPHiueK5SWy5nP1Oy4tS+P13aSnoK/MN6P2Bmql5w=;
	b=C9x0hu6Je7VmySHf2pGCQXjbu5pAcTC7XIPhJIWwdJD8AS3Xh//yQzi2eMiZHmcNAxAxoe
	ghTITnIPomGIa/BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704379589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=xpHPHiueK5SWy5nP1Oy4tS+P13aSnoK/MN6P2Bmql5w=;
	b=ZouwQajwJMnrTGsnXCchidw63GS2zAdH9Oq5FzakWhzcu/qOnwVOtGd7UAN5mnOhzYwuWZ
	as5VWZbvD/ZOu2G00EIqqhb/Qa4KkLTy1h1Es0KsZlw0uk+/bereppArf8b0uoW/3GVoRQ
	RXSkpX9AQaihNne3vqNuutstVBjTb5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704379589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=xpHPHiueK5SWy5nP1Oy4tS+P13aSnoK/MN6P2Bmql5w=;
	b=C9x0hu6Je7VmySHf2pGCQXjbu5pAcTC7XIPhJIWwdJD8AS3Xh//yQzi2eMiZHmcNAxAxoe
	ghTITnIPomGIa/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3084137E8;
	Thu,  4 Jan 2024 14:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tkLLNMTElmUzQwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 14:46:28 +0000
From: Petr Vorel <pvorel@suse.cz>
To: olga.kornievskaia@gmail.com,
	steved@redhat.com
Cc: chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/6] gssd: revert commit 513630d720bd
Date: Thu,  4 Jan 2024 15:46:22 +0100
Message-ID: <20231206213332.55565-3-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c]) by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423ED5B for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:38 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67acc0c1a35so531816d6.0 for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1701898417; x=1702503217; darn=vger.kernel.org; h=content-transfer-encoding:mime-version:references:in-reply-to :message-id:date:subject:cc:to:from:from:to:cc:subject:date :message-id:reply-to; bh=wZWSOIgKKMZd8u9zKyA1yNwvXWB4I60jQhkSqY/f7yQ=; b=UKXnxee8YfX2H3xp/WvVxnKeb0JzqWg7hA62DLURNINxsdnrNyuEPVJxibWzH5Nio3 eRC0DpOdYCXiFVghR7NgFYWSJh5PXY1C+SCwOgQaBvsK9k/iUYBJxh0Po/YaTbKP+QYW 6OB6zEUMFbkE6gsHkd5i/JNIEaVmB098DmS/wgF1DyuhNdF4Ya/3ZZ4KcSMVdLcqVAbP SgjvbZj3upMn3nBatWnOWIj7asqdGDSuqw4OdEjEi5/9jg0MXPjorucseU8Lch8SlG+e x8Gjls86KN/LSz8IVLyoCjfIDKUI9frVMfV7Qr4Pblfw8cRAYxSFR4P7YHtOtmhcD+1C CrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1701898417; x=1702503217; h=content-transfer-encoding:mime-version:references:in-reply-to :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc :subject:date:message-id:reply-to; bh=wZWSOIgKKMZd8u9zKyA1yNwvXWB4I60jQhkSqY/f7yQ=; b=nwWp6AqquWL5O5/m0oP3nZ5Q/cwJgckXe8FT/jK+FS2u3DXFO/gGzM46qaYNUkcvif dkzHUjkh4tacb8PZFl1DUOzIkGdGSG9QYN+GWcF2x618QvXDhXGIDuGCBZg7kZtL+LFu 3NET0++/QZfK2ADkUPTapDNCeLisoOrPtwNgT1kLQDSMRjaSaug1JJl6uCU9A1U6Zeyq mDoRdM3F/PFoKFFK4YvcVQNa+wb11PVn91YD1FrnyKAbxvfAaRi5uOKG7eNnhaSnegB0 8aiJNmeRzTR43/aIOh4gGfQhhrV8lOBTF5l4pLCa39y2rHynalkvB75i+t+tacYCJMHE IEBA==
X-Gm-Message-State: AOJu0YzQ3vGIZUjHROqsixcBllL1yjlz5rDKgUo5zfW1l+DD1NWbwUHi 0PVwBwtJjoaAJpM7sHgGIs0=
X-Google-Smtp-Source: AGHT+IEc2hAT+VbsdIdhZfImpKHnEYW+Gs7kMSvpLUF9Ua86CP0UEqkPW1lXtcyoSO9sy5l5PtI/0w==
X-Received: by 2002:a05:620a:4146:b0:77d:8c81:ea2d with SMTP id k6-20020a05620a414600b0077d8c81ea2dmr3245298qko.0.1701898417362; Wed, 06 Dec 2023 13:33:37 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b]) by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.35 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Wed, 06 Dec 2023 13:33:36 -0800 (PST)
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ****
X-Spam-Score: 4.72
X-Spamd-Result: default: False [4.72 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 SUSE_ML_WHITELIST_VGER(-0.10)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MAILLIST(-0.15)[generic];
	 FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.22)[71.95%];
	 ARC_NA(0.00)[];
	 RCVD_COUNT_FIVE(0.00)[6];
	 URIBL_BLOCKED(0.00)[netapp.com:email];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 PRECEDENCE_BULK(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-nfs@vger.kernel.org];
	 HAS_LIST_UNSUB(-0.01)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_TO(1.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

From: Olga Kornievskaia <olga.kornievskaia@gmail.com>

From: Olga Kornievskaia <kolga@netapp.com>

> In preparation for using rpc_gss_seccreate(), revert commit 513630d720bd
> "gssd: handle KRB5_AP_ERR_BAD_INTEGRITY for machine credentials"

Hi Olga,

Subject "[PATCH 2/6] gssd: revert commit 513630d720bd"
=> commit 513630d720bd does not exists. You probably meant to revert
4b272471937d6662e608dcf2b70dbc4b6dee76a0. Please next time revert on rebased
master to get correct git hash.

Kind regards,
Petr



