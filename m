Return-Path: <linux-nfs+bounces-16480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA1DC68906
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6960D4EF7D9
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 09:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AC284889;
	Tue, 18 Nov 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1XRwSE8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880732FB966
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458384; cv=none; b=tKilQE/W9FM8wDnvIPVTqRF0PKFFnwKI2IRZrxYr7Z1uE0melcRf0SYRqdedBviQ0+0y2t+FVCetG2/NAZnPrBpgHnvllZrkNjp3R2le9kuO7WTrDevPv1SUbGOuBpPiM4PPgyr6zs1lhFz6ST7MrwssWi8XLByUBt7hTGmzJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458384; c=relaxed/simple;
	bh=6Tonl0d7uuL8z1xd0MtnJYeIA23NOuE4CT1T2ZssRls=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n9fL2h7Brp+ASCsGVwQf2XAFtHmsD0SWg9u9knRnIR6hVodE4QhcIU0qbT69c9xbVQdAGUo8NytwaDJURrGE9dkcqpB06nCz7HyIa050h/9Np4eznCGSGL9zK/QS13qEUjlF4kiIKlyZwuQrmk3eNzzjRnAZHeFeiZiTR90yhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1XRwSE8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so9335814a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 01:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763458381; x=1764063181; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Tonl0d7uuL8z1xd0MtnJYeIA23NOuE4CT1T2ZssRls=;
        b=E1XRwSE8tJg/1oANKtIZhswIcAdcqugc0o2rPrFWQPfqgFx00Ldcg4C1uGAmfYWE2b
         twRQbAFEIG25jpZdDjWX5ZsDr16pwh3lRQImhETDbo+aOCjsMVzRkSf27yzd0c6Wf2ZU
         QSzdC6xpt6IAMp8Oa5jrhh6Hsas54NlzncZo7SEQDT60gACuSEwJB13kMaV3d0FkvpLG
         KvziEk0OHdbkRfT0zqw9zYLIxdauDqz0FD67VMqZV5CHdCbyeLjN/oOIFd7Wk8p7LMxX
         7+QNgbRPw7a0+CZ4lw26qB/ijakO05tR6/nqiNTg6gYJ9XAMjU4wInb40iwKSRF0oMSD
         NjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763458381; x=1764063181;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tonl0d7uuL8z1xd0MtnJYeIA23NOuE4CT1T2ZssRls=;
        b=uJugriOcOvmNFFovOw1QzUyb1kdS95eOEhAqehq1/Im+TVttK6A9+gqBKXzBVMs8AK
         nlwUqbTmVC/2BFrJIOFkhxouCQ6j8lhf/adGstPMUKBKhA8JfPCJAuUhFaGhyaBLIYik
         2vhrRwlMp2vZGJPVLtAcvluQ5qjMZW4lgnNohRDhkH4Mw+x7OI+nWDlLFV1eBswnjKNJ
         qxzTFuFPF+aLH2Afwta+PzvmlEcWias4MZAQbasA8N799CS0ARHNltqwN72ciZnn0DcZ
         FviXy9UjIbRZWn4aouv/PXYcHipkSu0qVJn06jGL0hQukNvTjMBNqxkrLgWroW08di/u
         AbSQ==
X-Gm-Message-State: AOJu0YzZQzuotAgrzNvSEZshaGizQHG9bl86a9kWVJanZVlesRrvh0Ju
	WzqeNWDH6E/LdmgPGswt3j2ZslY4cG0sIma63mba16ZGmag+L2Hg+Atb0TqhyJte10HJB4Fu8lx
	iNe+H2SfDjxgooVvosMWEfsVrgKJ4Urgk5oqn1Dk=
X-Gm-Gg: ASbGncv8yjFV88URN5iCsiP/NjYKBpw501au7xoPAh16WKDiQpMbFTuxzVYLks0Zc1x
	zQVf3TZOeWh7xEbToKBgOaHeVC+g3lOAMAMdd6wMX7uAhpPw4djDh5vkIrKi/FDuvkXDSA5vqn0
	qPiyaNST6Jn8gsunniv1JXYt6YrvXtxeQXNnIBarcdVL2Pg9vQnYypsvziPA1CrOGjDty11EONY
	Twm89eS3XQSLmRVbphQYDDt+kpxgZFv7vzEWtCUJcZRqon5wTu4DxRTXo3NJQ4alsjwTKg=
X-Google-Smtp-Source: AGHT+IGMsbv/cqYgY+NX25MNO/dfl8qa8+oOswwvnXMtYT+eNjNu5qglxROoR4YKUnfo2qGK/6D0HbEkVECg/rfRHXU=
X-Received: by 2002:a05:6402:84e:b0:640:9d56:50a7 with SMTP id
 4fb4d7f45d1cf-64350e1e0aamr12878472a12.9.1763458380653; Tue, 18 Nov 2025
 01:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Aur=C3=A9lien_Couderc?= <aurelien.couderc2002@gmail.com>
Date: Tue, 18 Nov 2025 10:32:24 +0100
X-Gm-Features: AWmQ_blRwaZmFviHNjJwwmUINS32xlvW5B4fYAjZjXou2qE4CtMVpP1m3V-Y0iI
Message-ID: <CA+1jF5pYFVb0=ToyPtGrtPYoZds1=mpHCZaFFR5hS-AfbP_RDg@mail.gmail.com>
Subject: FATTR4_MODE_SET_MASKED support in Linux nfsd?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does the Linux nfsd support FATTR4_MODE_SET_MASKED?

Aur=C3=A9lien
--=20
Aur=C3=A9lien Couderc <aurelien.couderc2002@gmail.com>
Big Data/Data mining expert, chess enthusiast

