Return-Path: <linux-nfs+bounces-10986-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F4CA78CD0
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 13:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF7D16EE4D
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F04235BEB;
	Wed,  2 Apr 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOSbTBU2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A57214A94
	for <linux-nfs@vger.kernel.org>; Wed,  2 Apr 2025 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591766; cv=none; b=UsBW6Zpq1ESh13YtpjTKy/PkiwvSLinKj/5y8Hy/a59qj7CH1aMu473LipjEYmt9LNixzdCgl1KzujXiQCSrKtTVfc9lsgj4UmjKAvYlnKJp1Xp4EEwighkd7RBDy59iYYepJLGJtDxEkLwKzDJaNhoJckX2849jAtmqaNNQ2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591766; c=relaxed/simple;
	bh=/ksHMeBu/p/asNzn0ejbgAzHS7nmF3zhaWIA6ZgUn2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=adfxFe00w/MuCBH4MnL+vLjMul9eXh0NOplaZjbeXEXnLIqnnd7wnTusP0DfSz/P4LT/77qQw1dpGe4AQHFdJW9jYIUBbTbYezr3oqTThLms/5EaVBw59aEe9ebCx1LN3ECEMdEoouYPVP858UTM8XmaRW5zKbBwaKDbpZv3+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FOSbTBU2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso5799622f8f.2
        for <linux-nfs@vger.kernel.org>; Wed, 02 Apr 2025 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743591763; x=1744196563; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPszXvzT1nBu1lLTF10nosvpBa1AQVUmdaJflyBmnvA=;
        b=FOSbTBU2yUZDuXFdijjS/bTo04BelqhiKRVjT8rPHXrXERtTdR/4Vg8C95WgQTWUkp
         rm3cT+b25kcM//rOIcqxfs71vOnUfnGTgF7NhotEUTzfZeFRMsAbRnVnMBeuwtrS2Spp
         0vN3RuVElf5bIcdr6iHX/BYrt+LpQbEpkUuwVM9KWZIJcH4JjjT3kWNZoGJUPlyKYwV/
         IWELFqtkq9W4FLbrnbhu2glbTUs8VVClvDXiw3bniidG0XaV5H1EBC9dBagaQknYeLBz
         ZBlziqjpRuGEPfE2XBdko3ozr+mbnu/UuqlKSZh8VYeTSwZkhy8OXs1hGzzNH3coiV09
         EzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743591763; x=1744196563;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPszXvzT1nBu1lLTF10nosvpBa1AQVUmdaJflyBmnvA=;
        b=A0v+ab7Glf4bqghkgSJRHUKrXcuqoDwrVDF5uCtJ2Hi/24l0opf4fJJWlPGtJYguRM
         EcfLfscxzWnEWCLS8eKfgXGnz7473JcUuZu5KDrIkv1GIuYMgLCuMPN1YGUIXDvCv7Id
         lyZp0aWa9hfPIJ6TwvkfsDCO0Veqf1HzHMWKeAmAoTn/4S6NJL/2P7ah3BTiKi801QGH
         7ynEg2E9M9Tx+4zufalxvnD//4QsNe5h1wqwk8tMLrSPX+2usGkcx9QznsNt8SH1Yq3n
         Wl+dbA0+F0q1TdACzsPMV1jlhq/nT6hV5opxgZvSqNgtcf8yVmOuoWxuf1prAyjZnPyZ
         sFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAl6U8V3SLAuto3OGPBPHh/QlY58vwfB9xa/Q9a3S3WP8QYyiYjLKR4WHACU0Q01vzWmt3c/XYNJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYRDYlOKY+aHYgg10xSoDf2JTW8hZdM3XnTdigKKUelq+QEgl
	V/uGNRUD9f//tcQP9iRgQfiIjtQD85321QA9jzmXfu/pEpQ+lvnozPjRdIs7G2E=
X-Gm-Gg: ASbGncvPVqRGIKTSRVQZaIYJ7l9vtJWQOhKaIVbk11YwOqTv/+NrU85Y6BSITT61Uer
	vP9AJ1OTz8h9167I8WHajnsM4/pfZfML+wlASB9Fdv903KYqDwKNhTih7wIPgDTJHkJedWqGDQi
	QwCCQ/tMAUvbpCHhNYBWaPqWmD71MUposUcjuU7avi6CQnUYM13aixzoVG1nAgMC8NYiI6bpW4U
	Ni4jtEAdxdSqUujTYY9uRKBlgjhqovaBqWq1SOQWOn4yVoRvcK7E2zhgChGN972R4hN5lrANrd7
	evIeU1eBWYXnxV0UC159mQnuXDQvW44aOXLDkyf+qtwQyj5iTA==
X-Google-Smtp-Source: AGHT+IH2PxxnwoGmEekj/JPGQfhyg6WywOXDfzxclh3b+yJlm63bf//RxWl96Bfbtzsi6wSpbo9I/Q==
X-Received: by 2002:a05:6000:40e0:b0:391:4977:5060 with SMTP id ffacd0b85a97d-39c1211d5b0mr12864765f8f.53.1743591762880;
        Wed, 02 Apr 2025 04:02:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b7a41b4sm16396725f8f.85.2025.04.02.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 04:02:42 -0700 (PDT)
Date: Wed, 2 Apr 2025 14:02:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nfs: Add missing release on error in
 nfs_lock_and_join_requests()
Message-ID: <3aaaa3d5-1c8a-41e4-98c7-717801ddd171@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call nfs_release_request() on this error path before returning.

Fixes: c3f2235782c3 ("nfs: fold nfs_folio_find_and_lock_request into nfs_lock_and_join_requests")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis and untested.  Pretty sure it's correct, though.  ;)

 fs/nfs/write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index aa3d8bea3ec0..23df8b214474 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -579,8 +579,10 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 
 	while (!nfs_lock_request(head)) {
 		ret = nfs_wait_on_request(head);
-		if (ret < 0)
+		if (ret < 0) {
+			nfs_release_request(head);
 			return ERR_PTR(ret);
+		}
 	}
 
 	/* Ensure that nobody removed the request before we locked it */
-- 
2.47.2


