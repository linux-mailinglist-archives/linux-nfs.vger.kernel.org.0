Return-Path: <linux-nfs+bounces-12231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3FFAD2C40
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 05:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF703A1C99
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jun 2025 03:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250EB221FCD;
	Tue, 10 Jun 2025 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MNBq6k6T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD745789D
	for <linux-nfs@vger.kernel.org>; Tue, 10 Jun 2025 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527335; cv=none; b=J2apUmWxgDXz/wt3ycBVyD3ah8H4zHWPMHKFO7j+X9h7gVsGjeyxg3jLJhzXqye4Uy6NqU4CAqEwi6L3kVcGr4cYUjJ2hVCzamOuXhHjw+QPlewXAI+fTaKMiHguFNwceUvvXrdA+RgLUV3Xbu+4SgLqRSb05eczEg509NYBvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527335; c=relaxed/simple;
	bh=LfDKku90Dd3qk/Tpjpfg+vTZqQ5m61fR/4fkUTRneyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tb9mERT76T73hBLs1cm3pUN/s26VuTaWYrRssr8zE7RhA3FmE0Z6sYZesaxgF7zBDoDXMKEbc5WiBuaWqLAgjYBcr/QGYACiXarvZwUlwrLa8c1fopTM6uSZ9Y0VcJiWWR6O0HaPu55obNd6f/oaMTXEA7xKT9Ok5hyucH+fpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MNBq6k6T; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c3d06de3so5676901b3a.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Jun 2025 20:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749527333; x=1750132133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfDKku90Dd3qk/Tpjpfg+vTZqQ5m61fR/4fkUTRneyg=;
        b=MNBq6k6TwDVb4eytjTBYfIBTtKcrmhehoA3eHH9jWz0kbDrJJLJCS/3c/YH09GK3bH
         A6u8Gnc+/m2x5GZtiN1z1DSuhLEU7Da8EvLuWBLdzCLEyY9Dq6dRWYkP6hhtTqgrgDV7
         HpO9Zey9CuNy1HaJGoPJ2zHIAQijYYwPzN1ppITeCA3ZmEbllYDzNXAUa7lAy/H2aCal
         oU9dQF8cS1BdaOjtidwWwEkytpK0M1atuxaHOu/GXp30R8E7rgVf7pU9RC2VE0bJI2g3
         TtMsJmeZ5v8kD4hOyH1OjKxtctmra3hvibFmeOMk8zTlow5DZaAIBvF49mZt4FObU379
         QquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749527333; x=1750132133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfDKku90Dd3qk/Tpjpfg+vTZqQ5m61fR/4fkUTRneyg=;
        b=KS3rXG2Z97uGWrAiLzEwH7r+WeQYhZJ7NtO2bqOhezvqXAtGrOU60Q2EF5ieBFSOuy
         sEOIZHVP/PIhH+rpUFSkysl4K8pzYXbCm8Prr5vBKApwRGJpL7b8AnJMj1pjlqESamTL
         Kzt521SyHbouE4Kd6+G/paHLyyt6bVZhJZFs6iqvDhsZQ/yf5H+APqiyJCy4iLhXvdV2
         2g1H0w77YATd9FS2BE0RCBWVHGBw2h9F9NkUupsewcQh3uEhaoFFxvPI1XdPVk70FgJ4
         KjeYPTogQfN3jRUVxprqNSsC81kiJ/aPrqt4DkRRFpiwY+gbprw7IspiHNbp2IysZ56w
         6wSA==
X-Forwarded-Encrypted: i=1; AJvYcCXocj+xLhBimReEv0Ft/XlAqvMkwgdFEQvgRI2qPs+2jNWnBVztBnB8QoIAL+wIyFaPF1ULoSETWRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYLdCgXvOuOatJIh/uLn+8OqdhWSAbgQ00xBwWUchO26AfOlw0
	wf5pHh+u8UQlUhouzhq/aRU1c5Z3ZMYyO9eN8XH++hHK5O6Ks6X2XnCWZgclrQkPT28a8Dct3rc
	vwRq+9/Auvg==
X-Gm-Gg: ASbGnctiXt9YQZ4JzCSPc5HhtwXdqXFfVhmG08O0yKAIgCw28eqCnXai/SAGiwPupJp
	nJeKKWflyGu0hEtGQ6OTcPz6FmlyQzrnQqjqePQGzXB02ciAVAsDlBnzTFNaM/WyDFWAJXx1aJM
	jSrNgBZAMVv7f4HxwJ/7nG+qKQ5uhsZ7mg14yS8/4tdHWl7zIYhfwATakVwpghoQFGm2go7bGwp
	eiXcBGbDiPIgikyhciy9UiYL0Fea/NJe8rMsRKaUDyt4GuxfX7vBJ4ry81Er/2vprLAVL33givS
	OW3txVK74+MP/E//S67+j63sq6XUekZnUSSqjHzTCrqw4USbRctjOTfHp6iZ/8OLQKHEZpNx4ct
	0udp4Kw2s1RcDQfkFqao=
X-Google-Smtp-Source: AGHT+IG1ix41IRlPEDG1HenvHY+yF8PR1xemRzGkkLgVLLnz1RDwPTZbUhRrHTkZMMX4Gu1C+XxPvg==
X-Received: by 2002:a05:6a00:2343:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-74827f159afmr18347886b3a.15.1749527332612;
        Mon, 09 Jun 2025 20:48:52 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083b03sm6488081b3a.83.2025.06.09.20.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 20:48:51 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: lionelcons1972@gmail.com
Cc: patches@lists.linux.dev,
	stable@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Han Young <hanyang.tony@bytedance.com>
Subject: Re: [PATCH AUTOSEL 6.1 3/9] NFSv4: Always set NLINK even if the server doesn't support it
Date: Tue, 10 Jun 2025 11:48:40 +0800
Message-ID: <20250610034840.36099-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.49.0.654.g845c48a16a.dirty
In-Reply-To: <CAPJSo4XSoTNVvH8MpZWD4W50u=U4bw6YBCnNeiJZpe2LT-YNYg@mail.gmail.com>
References: <CAPJSo4XSoTNVvH8MpZWD4W50u=U4bw6YBCnNeiJZpe2LT-YNYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 9 Jun 2025 at 09:12, Lionel Cons <lionelcons1972@gmail.com> wrote:
> How can an application then test whether a filesystem supports hard
> links, or not?

I think link will fail with EPERM on those systems. However, this patch
doesn't break existing things though, since filesystems don't support
hard links cannot be mounted by NFS (before).

Thanks.

