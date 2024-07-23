Return-Path: <linux-nfs+bounces-5017-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E9193A260
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878CF1C2246C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2024 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C651A139CEE;
	Tue, 23 Jul 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hcl-software.com header.i=@hcl-software.com header.b="ePaleAyM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34C136E3B
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744151; cv=none; b=UAuhITd3ZpknLumcjj87RmDQE2W66CWRBuzfKl1D8xv4WOtfJ4L8rtNlNQxZN22gs4ncZdmAr8EM1kNqeFFFoFfIZXil4gTs/2IYX+L30Pf3vPBGOU/HBZMJD9ONGKlDP7QIE5uK5SPTsVjENzs+q2JvKlYdf4tjVLp7sIRMLR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744151; c=relaxed/simple;
	bh=R7FDSPdJtjyCStbSWGk9Hv88VxLvPl6g96k624s4w04=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VAnS5kRENmUAQMGhJj3R5S/p6zmOB6v3CoVD0VEs0HS2Uxb+lBhttwSUohx+gJXJnklQaechYkHq9i7kj24deEONuQLp92BgcO5bzMprvhuFZ30BSGt9Z6KMnH7dxQw0rO/e/IUVMZBlEgc1/OcyZJdDz4FQMNwslmScy8H5kmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcl-software.com; spf=pass smtp.mailfrom=hcl.software; dkim=pass (2048-bit key) header.d=hcl-software.com header.i=@hcl-software.com header.b=ePaleAyM; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hcl-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hcl.software
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52fc4388a64so1809136e87.1
        for <linux-nfs@vger.kernel.org>; Tue, 23 Jul 2024 07:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hcl-software.com; s=google; t=1721744148; x=1722348948; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7FDSPdJtjyCStbSWGk9Hv88VxLvPl6g96k624s4w04=;
        b=ePaleAyM3gjSldFwEQZqMLURwKIggIHUNY0RhuJWpOpMjW7rkkFMTc4mRbFSAH3mcZ
         nIVFgFmQdDVz8gHmZlWv7OK7Hbi/J8ex/DzoCReQNa+oyJL26DT+XGfLDm5VS7Aiuy4I
         8GBPwi0B/jT5xroF5sLTx0nuiL459gQe5Bp47llG2hv2u8gssPIK0D1W0CeJiJbYuRg+
         4rLpWtbrh8EbvNvw2NdWmrkBlUHHLe4uXQb4EqFppD5XSJ/f5fdVONoz0srqV64acyXu
         BdhAw7f6jkFvhxZ/PTXM0KmjuN+KPry5nR5Gq643tFMf0ypenlOJHxlE+A/u4V5EDDnn
         WDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721744148; x=1722348948;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7FDSPdJtjyCStbSWGk9Hv88VxLvPl6g96k624s4w04=;
        b=D1FKbz3pgVZCYC0bB6EIKjqxnL/wy/ynBX8W31NJ/A3pF+yPPc9eDFk4ibBQ/QqLIE
         XaQhC9kPQ1MHe+EL5c7y1e4w4uq3oSBZyuEnA0rxxzpp9oKaOjm29vYQBTuTwElq/Sdy
         TZ0V+pWiI1rf8h14MG00n+irJ0ZsCT0GGcSwCoM3fIjTQyQY/i+dGeJRbeo1zslkwxuJ
         hemIGI3AR9X3XvRQ92RP4e6gN5WRKcJqJkvmG40OGE+e+eT5fYkN39tQqvzxdThZP+VV
         dtybttePQ34ilMNj0RnhPlNOvPfVKxqM1Tth9NRw/1er9hW6lSwfs5YKTBfVjKGScKhw
         ChaQ==
X-Gm-Message-State: AOJu0YwJZB9s6KrTmH3rz53HpkaI1ZMQmyg7SINrZmLu+wNoR1ys6Xfg
	dcRHixSHtt2My1m5QX+flRQ/GkG8Q/4cWHNg6g39Cy9vKS6MGmDU2CNbZSLhXenNkbyKslkNhjS
	rWOfDliYCEeezy0UYEJ3n2CLTIyPri4+aENjRHn1eFZeK/vlUs7A=
X-Google-Smtp-Source: AGHT+IGFrZltcCF5UnhKX7OYsOBOdAaP4bcPi8sN2+sR22ta1o9qRouet4KXUaGFpPZLS/Piq/0XiJuR7laNQgwi4d4=
X-Received: by 2002:a05:6512:15a9:b0:52e:9ab9:da14 with SMTP id
 2adb3069b0e04-52fc404dd74mr2345664e87.31.1721744147576; Tue, 23 Jul 2024
 07:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brian Cowan <brian.cowan@hcl-software.com>
Date: Tue, 23 Jul 2024 10:15:36 -0400
Message-ID: <CAGOwBeW31AThuSLW-aWE0wAz302qaXDaCKCOmmOPjCewB8rkgw@mail.gmail.com>
Subject: Limits to number of files opened by remote hosts over NFSv4?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am responsible for supporting an application that opens LOTS of
files over NFS from a given host, and potentially a few files/host
from a LOT of clients. We've run into some "interesting" limitations
from other OS's when it comes to NFSv4...

Solaris, for example, "only" allows 10K or so files per NFS export to
be opened over NFSv4. When you have 2500+ client hosts opening files
over NFSv4, the Solaris NFS server stops responding to "open" requests
until an entry in its state table is freed up by a file close. Which
causes single threaded client processes trying to open said files to
hang... Luckily we convinced that customer to move the clients back to
using NFSv3 since they didn't need the additional features of V4.

We're also seeing a potential issue with NetApp filers where opening
too many files from a single host seems to have issues. We're being
told that DataOnTAP has a per-client-host limit on the number of files
in the Openstate pool (and not being told what that limit is...) I say
"potential" since the only report is from things falling apart after
moving from AIX 7.2 to 7.3 (meaning there is a non-zero chance that
this is actually an AIX NFS issue). In this case, NFSv3 is not an
option since NFSv4 ACLs are required...

Anyway, as a result, I'm trying to find out if the Linux NFSv4 server
has a limit on either total number of files, total number of files per
export, or total files per host.

