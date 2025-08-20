Return-Path: <linux-nfs+bounces-13806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E53B2E5C3
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 21:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25E4A22AD7
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB92224FA;
	Wed, 20 Aug 2025 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJiQ67up"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416448F49
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719153; cv=none; b=Y0ag7Hb7QhoXat2CdFoA7lud1ntEaA6fnCIuFbgi6zBHZ30+4slrbsKFM6vr+rTGhc0UQvfKjEUwnkShlJEAjNj6DXel1BeFJ2CXBkmBd+UhvNc+W4KJ9fqXLTUcnHs14fMy/7d2nNqOvpO6FIaL6r3PQq1/MOrWXekzik3gH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719153; c=relaxed/simple;
	bh=5VAwUgxdtv2NugTzC7gEWP4Iq9QnLgFtJCUpn/M3C5E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZvWqaCfIini6fZJwMDTrVOm5k/SLKA7Ko0FEJ+7GaCPpJj+gaXZTWSSqfwaxRCxZ3rYSuW46DgkRMNfNU0GOnm+6z7MAFP642hCCBjrsnagZE6VFg2TkMidLtIbOhHeMrZEOBtZWBSLB3/Bkf9tezODt6APaI/mESt8uLUz391I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJiQ67up; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333f8f22292so2212121fa.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755719150; x=1756323950; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0SpfbHK8Q1MKmQ6au0fwAwV1m56VFGkhBMLs5kLHI4=;
        b=HJiQ67upaoJYbOawuLN4aLQQJoura44L07sirq8NJIdGd96DNBop5zY1DMJOmrixjM
         Ict2nY4b2TF5hB7r2OBC/NmJtwUjzIAiXAokCfu21ln4codOOSUUxtVVq0SitolLUmEp
         ck8dn/4kmc/9B7drwOWBXYeDiUUlKJyw6ng+JIc0kfBjezaQQSWZ2Sy02cUScxqHXoKq
         QsjLl8HBuhdQ+jeC1m1QipN9j5tUj9CHX1aSEiYey9zQ7OK1KjitsLGNlcpcCXVeznn0
         cs7JLCSBqOLBaiIHVyIKNjfV7QfgfeJD2CqbA5SOgHy4qxD2MJIR/I0isYhhfODF02iM
         a6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755719150; x=1756323950;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0SpfbHK8Q1MKmQ6au0fwAwV1m56VFGkhBMLs5kLHI4=;
        b=MqrZBCkhMCFltvfAeS6IOz9eVUeDF4LhXlpmbk+ghzkZwyubBEn5ScKDSYtXYcgAd3
         v6Ywb5lEfj/hsI/6cn1ltOoolBT7ork3pCrjlDce3fXDlNmAVyUeNQm8g07xStJiMLh6
         8ktupJAnYmw0fVzpjQVwC1m6+v/Sal0BkqduCHD2ASqGIK9mLB7ojDIm5M+XerZCVnyo
         wTQ1R/SJUB7S2O5duJ5bMf8VXB1AhveGuEU6uA/Wz6zqJ9xk5pzq62UBmFi7aPXCRrcf
         QmbL/IArhe0UiUUrqdEhtFyya0tACZVjFsCfN78Dspj/PGcpcTVWnF/R46idIso4QuHc
         85Wg==
X-Gm-Message-State: AOJu0YwaUGw2NX6HsNxS6jo1mbGeG3Py75Yhc0juJs/tN3N9oMxA/amY
	DgbjQCIK2MnOnmqnlIncvXZ0kpcYnl+uT66BfvO/FjQnSeSEOXFnyNmOpXkb7ryWRk0xq3B36Up
	ikCmpD3A2yQkvjlGyxjRxFSnJ98XE/l4rHvrjS2E=
X-Gm-Gg: ASbGncuBDlGTSnqxaCwvSQf2QBB2B1dsospisxsbDf9QRevl8PmQbyv2SOYEaHH5QWW
	MWVd2VYyF2u0WBP5Ao25sqC3b0a9tl9WzD1ZPHwJL2mNzxu/tfTcmslH+BbHD15dv6E4tw89ZIY
	Q+NGBv73642eoW6tUB0Bi75+EJL/ZV5s9U/NqfpOqIP8r17FsQp97mcNqnuO1Rb57BLu2C+fPkf
	CUJe7I78uIvgQDrPQ==
X-Google-Smtp-Source: AGHT+IGCte5Nyf4IXx/f6LZExAyYmEViU6SG0hivXRc/Pi1KxK6+4r1uvbrurjxSQYH1rBRi+MkNfQcvT+eDqFWndS4=
X-Received: by 2002:a05:651c:2208:b0:331:ebc6:7155 with SMTP id
 38308e7fff4ca-3353bd0a294mr13434401fa.19.1755719149882; Wed, 20 Aug 2025
 12:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Wed, 20 Aug 2025 21:44:00 +0200
X-Gm-Features: Ac12FXy58Vrt0YuHVrpogGQeaTXeCCWY6d8dffLmG859Wua-7NHVfPRrBjMgKzY
Message-ID: <CAAvCNcC2A_ShAUe2AZxvoOaS-E4=0OicvEF3b-0q9XKywUTadg@mail.gmail.com>
Subject: Using JAVA NFSv4.1 nio client with Linux nfsd?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello!

Asking here because maybe someone tried iti and knows how to use it:
Did anyone here ever tried https://github.com/kofemann/nfs41-nio2 with
the Linux nfsd?

Dan
-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

