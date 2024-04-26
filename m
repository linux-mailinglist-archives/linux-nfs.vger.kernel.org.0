Return-Path: <linux-nfs+bounces-3042-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEE48B3D14
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 18:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B2D1F235C8
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Apr 2024 16:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8B614C5BF;
	Fri, 26 Apr 2024 16:47:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4F2B9DB
	for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150068; cv=none; b=VwwjDN6zVAW+U5WjrFhqcRgL0SdRj6GQZQ1a5yKSf99vb1oWAJYUGj8L8XPGRGqKcwsPjlyssn7AKT37pMOhobrZ/lH7Pg6dNQTzLA4RP02mJmqhMwgSBjKVDgfw2dO05XeDIwxctHiKRzT08YmcJzV0p1jBiTqDFd4xJ4fyeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150068; c=relaxed/simple;
	bh=YJ6Jom6G97YN8w3EDwLjv3Cpk22lq6ED3j3LVJuaoDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j28Ne9M8zP2yh2rfgbAiA9SqEjjCTW6aZ+D2NrjLgh6BlEYh4zihKBlt6ZdGYxpjSi9sFoYFq3mTioOcJ+9L9waCp20F1bXup4v6kS9kjPgyd8BPDBr6On4pAMapYhlXl48YpF9wSHfkmVDb9qc1sYf7qFB2qIzg+a1vz4JBLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c74b643aebso1403206b6e.0
        for <linux-nfs@vger.kernel.org>; Fri, 26 Apr 2024 09:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150066; x=1714754866;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ7psnjiyD4hYo+pT2BvMWh7VOo4jdebGJzBPZLs+1E=;
        b=tSaLwRrlrAS1ccKjpue90KMS8ixqPfqLdKZfR2plwIxFXHZxZTDj+laMJeOJhIuPjO
         JmNjkjPBSQncD+ZRNmtata9LmYP1JA0aAls4GOI32T41+znQoSWYM0J9/wldlpBtyN7O
         Lj3nIBhVjPPzMQdZAWJes/r8k68A//1oh3ZVo0VLZWUGul/aki865Zy8OhyZ1rDX68kP
         MlBE6XM419OOQMqBN9wroT8cZTt1avmuxAMqKKbPCJ/YLBiX70wrEblJRe8dRFWAgBaH
         i8BZMHQeTF7dasbbmSZjOxZuIkI/xfexM359718hl81HDQWHeSB+Apy2GRgbkjxkHkhA
         LGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Cxo7LfngG0ng6MbOgMyv6GL9ERfalfA+502kjkApkfnC6DhQNSnUNmHpWuIbUWE8ACmp5enY3XDpNI1HQRexuZzSX/OtEq2h
X-Gm-Message-State: AOJu0YxUXlTNklsaw8axMfhyt8vqvHwgB+tp2TNiKWMYEk7vcWQoCtnn
	qduaCCmbcgh1iFIjh1mRuxUW8aDNyLkrNr+uRWDZpWp4OJ5i1nPM4aauaO+duw==
X-Google-Smtp-Source: AGHT+IFibUOOBHj8lc5K8tcyd9ZkLRAAIPwBS8+jyXPmqanl08PNgrfJy0N2Q7nOV0BAibme0p4DDw==
X-Received: by 2002:a05:6808:200e:b0:3c7:4976:7923 with SMTP id q14-20020a056808200e00b003c749767923mr4768274oiw.39.1714150065853;
        Fri, 26 Apr 2024 09:47:45 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id k11-20020a0cf28b000000b006a053b4c3adsm8006054qvl.118.2024.04.26.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:47:45 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:47:44 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-nfs@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>
Subject: [ANNOUNCE] still co-maintainer of DM, but leaving Red Hat and
 joining Hammerspace
Message-ID: <ZivasKvjSpltZOh9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

After more than 15 years, today is my last day as a Red Hat employee.
I appreciate everything Red Hat has enabled me to do and we're parting
on great terms.

I will continue to co-maintain DM with Mikulas Patocka.  Mikulas will
be stepping up such that he does more of the DM maintainer work
(reviewing, testing and staging changes, etc).  We'll be working
closely to develop "the new normal" but we'll likely be switching off
who is taking lead on driving changes upstream every other Linux merge
window.

I start at Hammerspace on Monday. I'm really excited to take on new
challenges via Hammerspace employment. I will continue to have
meaningful Linux contributions to DM _and_ new areas of development
(NFS, etc).

Thanks,
Mike

