Return-Path: <linux-nfs+bounces-8867-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D516F9FF749
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 10:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424D47A1709
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jan 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94B5199234;
	Thu,  2 Jan 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b="FDUARCEo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4B199396
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jan 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735808917; cv=none; b=Isz5UKkGeq4tgdFtxsBo7MRvC1uoB5+vufM3QdawT8RhVzpNXVikRTtrIO5ml20wKoNWOWK6OKjL30F4gDjXXeTdBJJ5fQABZCKVfFu0ijNwxw0NotrY+n3bapocw0onsWV2iMzK82ErdTd0YEGdOcKp0cKqy1DmLHKjdVfVZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735808917; c=relaxed/simple;
	bh=0cvnYETfipHlLkD9x5/vYpqzzWKw6995sJOtWNiXK18=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qwHLVL7g/xZbDiCI9s/740sAFPWsJxvI6hZNgJFLoYxc93TH0QZ8jtaRHWglyeLpsywT5bxavRcnkzrEHmgjuiwdSI4yxPm8oIKyBTE6MQq+rmUqCc0KryxbSVnEq4jmP3tpS4H9Zj4j8iyWi2LcZ1D+lEXXrgnPa13lzGflsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com; spf=pass smtp.mailfrom=vastdata.com; dkim=pass (2048-bit key) header.d=vastdata.com header.i=@vastdata.com header.b=FDUARCEo; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vastdata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vastdata.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54263b52b5aso935440e87.1
        for <linux-nfs@vger.kernel.org>; Thu, 02 Jan 2025 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1735808912; x=1736413712; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0cvnYETfipHlLkD9x5/vYpqzzWKw6995sJOtWNiXK18=;
        b=FDUARCEoyhCnplW/OPAo34wo0jNdci33JM9NeiVsB8soFYzhxiEOd/yEp+PwLfMs84
         QsHMS58BuetFIaGwII2GwvQhONGcm6pbQ1zWZSHKIzO97IKgjprvZ1IzwUshSSqaFdM2
         +xXG6bd+jNSHpXJ8OPlL8b2A87ZLGfgWRsUp4NSF4DXapUXAxhPe6dEPho0Snbl5KAzo
         HyMCbyx3a9D0KfSwvxPCpev/PqdSEeeex77aNRu32dP60TxNpuh+hjJEaPj8YYgr5U4a
         hbKqzl9lYZXPTHhuEIA47Hcdjk235VoKv3i+FVUnz58bc+3yQxM9GVqwA5nuG190xgfy
         axUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735808912; x=1736413712;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cvnYETfipHlLkD9x5/vYpqzzWKw6995sJOtWNiXK18=;
        b=CbwkyKJq6NL4JAxjOrS/h/ABCgo8g/SOqorrEwGkCQRfQ6p1LNzN7EgjsOgEspqfz8
         SrkFxU57SG7VAUNT6h5WvS0cYq65/j6221r3jlaDGmc8BAmxU+xPm90HdLfvregH1tF6
         g0bMq0n0gYSPdiDBq5vuvgX1vJt0kKZZKzFrOEnzZUy4c1NuTO6uC+71Ctwt+d0Z0jXv
         cD3V1YfPzM1rSRg4EJh0CVWCIQPRwe20HcAPunejhz9KI0yRT9LTQa8V3Ji4E5ZneDah
         zzRA2YpuLILFBjCaB5AVZ3+lYjprwDgErMI/zO4sgEylVjKk9+B5TqqNJ4NQUpWJzLGg
         JaCA==
X-Gm-Message-State: AOJu0YwwdOAlcKR8kTYlnJdm6XHBoWCyD7+xziKNavTgUTpXr32yZvni
	M7FS33ORQqNhirbpRXKYWyO7Svx11CTf2+9UVg7cQVr2JhAwrlweYvmVy1B+V29d/IQRTyzoPCm
	iKz7CofUzhqT0yDeP+RjFIsu413cToD82hD5gIs60+R9VG6ebYbQ=
X-Gm-Gg: ASbGncvcPJVcDSf5kfWXDkvMcsmKIa9xYPwdtZD51u//s1eQTJe+YmO3rOue+WQk7rr
	2UQHun/2sZL18JqxUHdchL7rMHiQP1pqJ6erh
X-Google-Smtp-Source: AGHT+IEe/2AuYV/yJQ+07qTVLpRWVgIn4O7jwX+wU0EFuwDNaAm7jnQ7OZKR58E/Jw9xmi1poGg/wKqkCK/4wuKHEWw=
X-Received: by 2002:a05:6512:1094:b0:542:2930:4377 with SMTP id
 2adb3069b0e04-54229586738mr13514857e87.56.1735808912395; Thu, 02 Jan 2025
 01:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shaul Tamari <shaul.tamari@vastdata.com>
Date: Thu, 2 Jan 2025 11:08:21 +0200
Message-ID: <CAFEWm5DTvUucAps=SamE5OVs0uYX5n4trFf5PBasBOFbEFWAfA@mail.gmail.com>
Subject: Write delegation stateid permission checks
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a question regarding NFS4.1 write delegation stateid permission checks.

Is there a difference in how a server should check permissions for a
write delegation stateid that was given when the file was opened with:
1. OPEN4_SHARE_ACCESS_BOTH
2. OPEN4_SHARE_ACCESS_WRITE

Should the server check permissions for read access as well when
OPEN4_SHARE_ACCESS_WRITE is requested and DELEGATION_WRITE is granted
? or there is an assumption that the client will query the server for
read access permissions ?


Thanks,
Shaul

