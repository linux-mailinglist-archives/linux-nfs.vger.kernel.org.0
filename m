Return-Path: <linux-nfs+bounces-2388-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C0B87FA19
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 09:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AF71C210A7
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C953E34;
	Tue, 19 Mar 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTCLI6zG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C44594C
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838017; cv=none; b=AnY3bZF5Tn0vEIzYimmcR37uW9NZoWJKWUk5OJYJi7ZVhSc1aaAOSk3duwwAizc+jMWXOdR6GTia6mfWFqRLl8p/u7dqnhOaISzDaid6qLKHGqSmgeKR9Ybh1jPTDQQuj0vzm0Kzfd6HqcgVYxgL3EuvhyFR8kx3nUILS4BDwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838017; c=relaxed/simple;
	bh=D+prbASqM7Qx0CcpXWuFnu3N/dX96npzMAmscxZ6Up4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jDCsa9P7L6goXE6TEYelGN8rSreawh0l0AXAgmK1aJgNBSXqQs0AirAUC157KiF5/Tl/NOtmYGq9137P+Zd6fF2eddZq/Kzhr1jYTWikAtx18NMVeHFYceXxew05V6qTQnmF8eRI54W5aTmikWGXm/UyQZBMLYtoPBqFlSu8lP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTCLI6zG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56b95efd37fso460942a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710838014; x=1711442814; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xCVIVKUnGHwRJSA8hqJKgUSoGdQOzHX5W57/kXIUW2Y=;
        b=cTCLI6zGI3G2hXeeLzp1LKM6GY4eUmkybWl/YqRxxW/03Oh4tgajNTus53lTvsEQFx
         VdsbdahRD1e1s8vN3ahq0KksOi/NIi06mOb3uVBec/ToWhfaglui9LEJoefKcbarazNt
         Uzjudoevnxt6Fq53pcAuBKD67foYFOVipkJrhchrZYIYM1daKRvQTuJYulqkY1aGo+Zn
         +/MocjMsPfoIon0sBXXdJ+2Fwftyn29e/vzr/LMSnLYFClfThroIP5To0ytyl4Bhm0eP
         3N0nnYt6xY3Om1QJnUBf41GzyszBjN26m1+Q8p9or4snE52/ktLdt2/iXurRhTAW7Do9
         w1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710838014; x=1711442814;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCVIVKUnGHwRJSA8hqJKgUSoGdQOzHX5W57/kXIUW2Y=;
        b=uaqkXVwvqhVOAZsj7JoIe7EryXpCGRYcqs5ziSwovZIRLzjwpGW+gAZDrwODUknnkB
         igFlnuj76OjN4LnI4IRxGe27C9lctG1Mhrv4j2D1KFm/dCtBN3bAPBldQP7sFelxX4fm
         moK2FKF34/xZ48lwBOJUPAMzZw5Rj53r50uoPV/yVvWD/iUWEv0LTQnNDF76knVTgjBz
         n3HNeqwqEcYwIWuUD93VBH86LXdVOT/9Z7TMGJ0aKe/j792wLWplYDRm+4GAgKaHzl4O
         pKyQHKxIPPmCyr9P1Ddkhq24mMifPkrme2MxsjhTehOmCebJY5PWsUodSmDlgEKGATTX
         /nqw==
X-Gm-Message-State: AOJu0Yx9Pdel+dSZnlM55WUsmd/lDCFos99LUREDFsAUWZKIJA6thwX2
	OyRm0RXcOa/orQAKNS5PEgLdRGfEmFLoApAcsZPPjcAjw1EKXyJoH2iBaoGKGcYwnrGGCo0PrcS
	PqQhdhCYLhBWckDJF30C0ooxyYLvMqcVqK6g=
X-Google-Smtp-Source: AGHT+IEuF9u0zbllugqMgywDabEKNja/yn/loG8Q0VdDqg7po/jkBeLJsnr3ynKY5BQzvg+Nysf1cTAJSf2fKblF6dk=
X-Received: by 2002:a05:6402:414e:b0:566:18ba:6b80 with SMTP id
 x14-20020a056402414e00b0056618ba6b80mr11777694eda.31.1710838014018; Tue, 19
 Mar 2024 01:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 19 Mar 2024 09:45:00 +0100
Message-ID: <CALXu0Uf8mGEAPSfoWw=FQahAeRmEqaeRomik1YMYM0VX91oT8g@mail.gmail.com>
Subject: /sys/module/nfsd/parameters/nfs4_disable_idmapping=N by default?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

How can I configure
/sys/module/nfsd/parameters/nfs4_disable_idmapping=N by default,
preferably in a way which works for all Linux distros

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

