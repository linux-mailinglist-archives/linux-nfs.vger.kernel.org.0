Return-Path: <linux-nfs+bounces-933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C67FB824429
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 15:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523841F24923
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9222A249E8;
	Thu,  4 Jan 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sEzGIdFo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FytJ5CiW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sEzGIdFo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FytJ5CiW";
	dkim=permerror (0-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeMaQGm8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99867249E7
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60CE521E51;
	Thu,  4 Jan 2024 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704379975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=dg0aC6MijrixJwePqfCHhmpJzkbRSFJZDrMVVB9CqUA=;
	b=sEzGIdFoQ2gDIzeWBEovuC659PtmhSytB4TVVSmteXKo5X4YyjTRGVlPRUkW2FicEMQGS1
	4FLupkHW3jfkXdcJZbwKy2W598wSR9dRMddn3/snGAatUUSpeyDvbHKBRYQqBAcBKBGRTV
	24oRNDqujwq7UVEjVrVJAfkjbw34ziI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704379975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=dg0aC6MijrixJwePqfCHhmpJzkbRSFJZDrMVVB9CqUA=;
	b=FytJ5CiWyyvyzA5CX3vmQ23UiPO9WeCD5vsTkH3c4sHY/9Ls3oHwxwCqhtAWNnM2O7I6qj
	R7l/gXciZ9bK9OCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704379975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=dg0aC6MijrixJwePqfCHhmpJzkbRSFJZDrMVVB9CqUA=;
	b=sEzGIdFoQ2gDIzeWBEovuC659PtmhSytB4TVVSmteXKo5X4YyjTRGVlPRUkW2FicEMQGS1
	4FLupkHW3jfkXdcJZbwKy2W598wSR9dRMddn3/snGAatUUSpeyDvbHKBRYQqBAcBKBGRTV
	24oRNDqujwq7UVEjVrVJAfkjbw34ziI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704379975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:list-id:
	 list-unsubscribe:list-subscribe;
	bh=dg0aC6MijrixJwePqfCHhmpJzkbRSFJZDrMVVB9CqUA=;
	b=FytJ5CiWyyvyzA5CX3vmQ23UiPO9WeCD5vsTkH3c4sHY/9Ls3oHwxwCqhtAWNnM2O7I6qj
	R7l/gXciZ9bK9OCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18BC613722;
	Thu,  4 Jan 2024 14:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FNqgAkfGlmX5RAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 14:52:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: olga.kornievskaia@gmail.com,
	steved@redhat.com
Cc: chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/6] gssd: revert commit a5f3b7ccb01c
Date: Thu,  4 Jan 2024 15:52:44 +0100
Message-ID: <20231206213332.55565-2-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732]) by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34BBD4B for <linux-nfs@vger.kernel.org>; Wed,  6 Dec 2023 13:33:36 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f3c8fb126so1124585a.0 for <linux-nfs@vger.kernel.org>; Wed, 06 Dec 2023 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20230601; t=1701898416; x=1702503216; darn=vger.kernel.org; h=content-transfer-encoding:mime-version:references:in-reply-to :message-id:date:subject:cc:to:from:from:to:cc:subject:date :message-id:reply-to; bh=0OGTR2attaRq9HgZ/r5yNcQl5SlG230w3Em/r6CZfd4=; b=XeMaQGm8J594oEnYq03l706YGzQAwQdS3kPR5DpDbi2triWm50r9AgU78HG+Z4AUql cfr0jiyUJYqKXUtpY1PguFYOCfsn/0U+T5Ewo1iag8Q4E1U5KRQj89A0hEoNQHK/MC7B 4ZdfcWH0dFu6XQ5VZOkQ0EBtVcI2ZrWOD0IRCwE+DYLgREfY5jzgRtPaaYC6JIGo7yTY wrXL3RuK2ttq7UKShsNWDAkHbGEtPGp/dnhLxyXIzYiYeK7r1T0JjOLblVw5lz0NXt7N dpyew92dtVfHBteO9SGvUXIyX7IRdX7BbFZYsthnC5dQBk8xw6s0NAM2gC0+P0pCoOXu pU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1701898416; x=1702503216; h=content-transfer-encoding:mime-version:references:in-reply-to :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc :subject:date:message-id:reply-to; bh=0OGTR2attaRq9HgZ/r5yNcQl5SlG230w3Em/r6CZfd4=; b=CjFGy9hmxpVr4exESTl35A1wh7TunS3bbseXae8cm1+mOd9f8S3TAYtG5l4J0iMKpo DbpIwJzgsVT/2w9IvXoFhCqwjw5WHcJUT4jOAqwbwwDaNuLoT37C8UsU2LGJ5lzBX9s0 lLloFY83InuSVSlrm0Fhkff0pVj3Lh4sMu2RdtPQ5WnYIOaC9424o9u/SEGWTAQaR4fL SkXEJeQMJP4lFHY+npXZOvnj7225S63KeQQfhrALV/f7fH39fF4r3PCiqVr1rEtIfR1r QrTbTR7oTvxQHwsVXKdMdjMankkgUG0WfLktuFBNh3iF4Evc0tQPg6XiLW6Z/Z+wdrq0 +ixA==
X-Gm-Message-State: AOJu0YxXAV43abfCGNEXbv4BYeIvVk+wEn6wWoJ9mZMdG1ws3f1Tl9Jg Wd538gmhoRKQ/5qjsONR3vQ=
X-Google-Smtp-Source: AGHT+IGVq6je1saKrJ6OwUxEIYR/miUBiVtcqSRVey1EoEQE5X1niQ1GB8WkWL5AB5w4HMWsL72cSQ==
X-Received: by 2002:a05:620a:4141:b0:77d:cf5d:1bce with SMTP id k1-20020a05620a414100b0077dcf5d1bcemr3239989qko.4.1701898415723; Wed, 06 Dec 2023 13:33:35 -0800 (PST)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:b4ac:108b:be40:79b]) by smtp.gmail.com with ESMTPSA id ro3-20020a05620a398300b0077da601f06csm256435qkn.10.2023.12.06.13.33.34 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Wed, 06 Dec 2023 13:33:34 -0800 (PST)
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sEzGIdFo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FytJ5CiW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.69 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 SUSE_ML_WHITELIST_VGER(-0.10)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MAILLIST(-0.15)[generic];
	 FREEMAIL_TO(0.00)[gmail.com,redhat.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.04)[59.03%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_COUNT_FIVE(0.00)[6];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 PRECEDENCE_BULK(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-nfs@vger.kernel.org];
	 HAS_LIST_UNSUB(-0.01)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 URIBL_BLOCKED(0.00)[netapp.com:email,suse.cz:dkim];
	 MID_RHS_MATCH_TO(1.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-1.00)[2607:f8b0:4864:20::732:received,2600:1700:6a10:2e90:b4ac:108b:be40:79b:received];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 2.69
X-Rspamd-Queue-Id: 60CE521E51
X-Spam-Flag: NO

From: Olga Kornievskaia <olga.kornievskaia@gmail.com>

From: Olga Kornievskaia <kolga@netapp.com>

Hi Olga,

> Subject "[PATCH 1/6] gssd: revert commit a5f3b7ccb01c"

Also a5f3b7ccb01c does not exist in git tree.
You probably meant 14ee48785f97dbb90dd199698d838da66c319605.

Kind regards,
Petr

