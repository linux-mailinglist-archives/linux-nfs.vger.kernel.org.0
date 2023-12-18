Return-Path: <linux-nfs+bounces-687-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393AD816D27
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 12:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601D41C23312
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F14358AF;
	Mon, 18 Dec 2023 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM5aN+21"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091D3527D
	for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so1059443a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 18 Dec 2023 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702900175; x=1703504975; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNU2OQ66q7I7Mwdi15MGvsuJJWJeBtMHWU/b2je3XxY=;
        b=WM5aN+21OqQscMww0lXjqQHcI3i18u1n8EH2keSP9ZdFWQEirqqeNGn/0qs5Ke1VEG
         Eh0FO4onaeFNHOpCjkGIN6vaHkLGZaIJ8mqkc8HhTqDNd1N7VL2g+eYwQvgWZDCn7Vkc
         H6VFsSxmFZ/5DPpUvw+y1qcfeZs3iS45zzL8zD/sGWvC8J73uJpQ4IO2fOptw0KtOZep
         qAa9FdOSbUbU0UiTtZMnSOdDGyLp4H1yTITENJAo0GUPyngZNeA7muePytDls3pNTXC8
         YZZ4j5Mmrn6LIj5eM2+Of/W5vGk8pu7N8+ogHlxyL/Oq5Dk9zSfA2AcmQE59zU8mJmEE
         MwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702900175; x=1703504975;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNU2OQ66q7I7Mwdi15MGvsuJJWJeBtMHWU/b2je3XxY=;
        b=Sw1F0wsfV+Kbq3y+ehyfl1EaK5VRYwk01D/4gLvrZqpqjWrNoAMmjr1xD/MaKV+toX
         ru+OTAWIwUHnTQYzMGZDrq1WeR9QmNqRaDTz+QfNfc5sJL6Zn3iMPIgg8Y7rz9rlDlz0
         d4YYLSzQATySskRzxNk0fKksMaxB9LeRYnNVgR3XuIANJYnufScxmhTrSq/6RnCHjaHP
         8G+5jMeH/sz48XNDN3GkJZB3ZZ0OrWT3h9x7XVNItj26fzyhy7nFVt6fOcUsM78+S6mT
         LRdrNx/qvjppjh9J0afPVyu9z7WR6IoD7DMUR5dm4zU8A9+4OCuIqg/cMpLg0QSnd1AU
         EEYA==
X-Gm-Message-State: AOJu0YwRuAYl+kbLn8q1aiImvXpg6oAhjhaHOjKC5mzsc+5xeiKi0FOU
	4gqyxCPiHoypHpS3pBzR3up4LnVMRB5NT3laCmZD+J7pRoY=
X-Google-Smtp-Source: AGHT+IErebe91pJ0mydLNDlFoD8Tyert1C0v+Br+Vr7x2/mmrOP5QPY/3cxR2z8z1nz1ElQsQ8cmKY6u2FAiWcPFiAA=
X-Received: by 2002:a50:c355:0:b0:553:7a61:3f02 with SMTP id
 q21-20020a50c355000000b005537a613f02mr148548edb.13.1702900175032; Mon, 18 Dec
 2023 03:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 18 Dec 2023 12:48:00 +0100
Message-ID: <CALXu0UfJhNzETL_xFhrXYkxVSfkre836ed9nGyqyo5WxCvQ4aQ@mail.gmail.com>
Subject: Realtime NFSv4?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good morning!

How feasible would be a realtime NFSv4, which can guarantee NFSv4
operations in a constant time manner suitable for realtime
applications (similar to XFS realtime support)?

Yes, I know NFSv4 uses TCP, which is a bit allergic to realtime, but
aside from that (there is always RTP), can the NFSv4 protocol and
Linux implementation be modified for constant time?

Ced

PS Credits go to Roland Mainz for pitching the idea
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

