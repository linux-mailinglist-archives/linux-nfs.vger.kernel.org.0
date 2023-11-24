Return-Path: <linux-nfs+bounces-68-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5A7F6F01
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 09:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B817B20D2A
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B41B4C6E;
	Fri, 24 Nov 2023 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeKrP9na"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5A7A9
	for <linux-nfs@vger.kernel.org>; Fri, 24 Nov 2023 00:58:01 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso845538fac.0
        for <linux-nfs@vger.kernel.org>; Fri, 24 Nov 2023 00:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700816281; x=1701421081; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6LhAboDm6sUuuCQVgP+c8PrU6vIFFbuKKGvnvRsYyfY=;
        b=OeKrP9naXo9VRDYGYfG0EoOHxYwN+4kxVaNnfzMx+p6X9b2+RVuAnS0+fmGn0flmmm
         xuevUq5cmov0m4/K6rY545OYIEE7lTJV9b4zDy7ExcXAGkDMOV7ggkMIgcUgQE0mlZqC
         wxB+VwCSZY9b2OoX6XTHrZb7hItNpuUOp2KhUBMttuzCZGwNDm0LFXkez7BSd+/htpvU
         693S0DgJpTFBdmd9HUKHyFEposkgoYH9NEZeUl5+1HkBkVOuPUfOCLUP+qfLHbtETs+X
         sndiltgrf4saprWRnflx1JN2pruJjsRX2jv93QieOKxnNCV06t/ELLzjMlHvCduqgSiO
         trOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700816281; x=1701421081;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LhAboDm6sUuuCQVgP+c8PrU6vIFFbuKKGvnvRsYyfY=;
        b=p9L/gDNGkY6J0NdlROM1n9i65kT0GAIE4FMQxVuVij85qLj9WwvmjtIk6tzlEv/dfp
         WsHFljJWtQynLNWuKDovCISno3tgh3Av6/KS4mG3CRtPPiR8UDJRtPqC/4F1YwGBewGN
         f6ppNJE6JQ5RLVx2dXLzQKmpOU7wVk2ObomRyAaTCIf+fFX0RhkyNZqwb/N7nFhXSC5s
         tyVNau9qt6u/e1cZZBvUroJ/fUx79upwCLb8O1tSveOo3mxiNf/HyjJ+4lDYNp1D2m/q
         YHzBG2QUHzci4ct0FxbySZdfuaRPktFJrW+M5wkdA7CMhl8/F8aowwkF2K9Q4Fh25h1j
         AKMw==
X-Gm-Message-State: AOJu0YxdAB3jb9WO4RepHZ1/C1NGluyqI/yARd+wEZhIMdJQC3m84oFX
	zBfdQKkS7YZyCOBN0+3DW56Ft72nqGu5wOwNNQpCYvaoRxI=
X-Google-Smtp-Source: AGHT+IHLh5xsIhSyHawY0M8H6Ga22qP8JuO3MudnXsM1rLEXiONio9/XKU4dnQvc/jHJmqoDjpkOCO4EqJfjrihURdw=
X-Received: by 2002:a05:6870:5588:b0:1e9:b08d:69f0 with SMTP id
 qj8-20020a056870558800b001e9b08d69f0mr2135568oac.51.1700816280936; Fri, 24
 Nov 2023 00:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wege <martin.l.wege@gmail.com>
Date: Fri, 24 Nov 2023 09:57:50 +0100
Message-ID: <CANH4o6OdF=hjLtZ1_jbqPjexuenYn6cSvxFrJ+BUUDQv86DRzA@mail.gmail.com>
Subject: umount.nfs: /mnt: block devices not permitted on fs
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

We get a umount.nfs: /mnt: block devices not permitted on fs in a snap
container on Ubuntu.

Can anyone explain what is going wrong?

Thanks,
Martin

