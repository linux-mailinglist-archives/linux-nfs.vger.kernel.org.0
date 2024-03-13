Return-Path: <linux-nfs+bounces-2281-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D587A9CA
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941E21F219B8
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A218B446AF;
	Wed, 13 Mar 2024 14:52:24 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84BF446A2
	for <linux-nfs@vger.kernel.org>; Wed, 13 Mar 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341544; cv=none; b=I02W2yZphTFu4pddTLjZE64rdQg+DNVo4vzPfimKOWR5mJWPsnJUQCMGFZ2yrEm3j7iZhpJFto5Cux/jfeNM6OXkiHVcaIK2qtaklaSc1IWWKM5+2Jv47wdLLDd59dXxwAXI1FQPf3bna01egHqk7tfUlzEdToDTiV53dGJkupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341544; c=relaxed/simple;
	bh=zPEOqxsbvkGJMal4Hb1rA0ScHseYmJQaPh75iPtnvbw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DqRmhqo1l4v8Mt4kmrZm2ofQvXkDFEPD1VSJO9emZKPFIfRILs+t543vWW+Fk9JF0616AEodJlp92X9SPACLI4GLpptXRgMa7OzRj+xzrks5uy0ZGyIMPUpfqTKn4hv8rqdPGh1YV8IRC7O7GFAfvD8/UnayffBJocUZ9lGZ968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c8bb4813e9so63469839f.1
        for <linux-nfs@vger.kernel.org>; Wed, 13 Mar 2024 07:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710341542; x=1710946342;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXC12/9QMDdICrGdqcJZBzuq6vtwXUGs4kTomT8IzW8=;
        b=aN3hNZIv20+kwYoCeV5eM40Lh/wq+PgmBpmY/H3nITrZ37/8CWA1ARKtOaph5IzjJm
         74Kx3OkZbGz89NMcKVt9KigsSsvGfey7KTUOXmg3HZBCb9EenUqSKelRfrSf6nebxLr3
         rIjsKYRucpzmtIkfE5TDtbvyj3d2HWQVSCas7zTvNFHjDIhA0OB+niTZ8AmbTcixMqS/
         DBEHbRuqD0YsDrxkS/SV60cyniIrItHwl3jweRMXWh6kGOkaYkJRq7O0rQWHT8V82IZR
         yZZ8H0D5mdNEVLeBTOSMR4I4GyAr5EnBHfCkGupl513dqjuyz9BDggYPr6N4ss+ybYOC
         7dkA==
X-Gm-Message-State: AOJu0Yx36/1yZJErvGaOmWU33UnlR9iPiK6+0U3X0VsujqxQyLkrSvAX
	OZzJ8fiu+Bp3k9yAag5xVhrRFUjGsMhEIs7oN4Qn670W8iuS9OJhCZ7QqZ5LhxL1rnvnU0T93ap
	+LRPKyAdEY8TZDlwgW8xqlR17NsXfmuBmlxY=
X-Google-Smtp-Source: AGHT+IH722aPNdCzaFjNIqATLwICckxjKeRC9QDh9CmEP43ErrgzEP0PIWT2NL5fXUe/DesJFXEtgiRRhgCguHZlon4=
X-Received: by 2002:a05:6e02:20ce:b0:365:fe19:550f with SMTP id
 14-20020a056e0220ce00b00365fe19550fmr171714ilq.6.1710341541728; Wed, 13 Mar
 2024 07:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Wed, 13 Mar 2024 15:51:55 +0100
Message-ID: <CAKAoaQnzM9VqvW0FddRzKhPKHvEWV4RKfSbuX939kR83ZbzapQ@mail.gmail.com>
Subject: Linux /proc/fs/nfsd/clients/*/info - where does "Implementation name"
 come from ?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi!

----

While debugging a NFSv4.1 problem I noticed that the Linux nfsd
somehow gets a "Implementation name" /proc/fs/nfsd/clients/*/info
files:

Example:
---- snip ----
$ cat /proc/fs/nfsd/clients/3/info
clientid: 0x22d7004e65f1b8d3
address: "104.102.54.63:666"
status: confirmed
seconds from last renew: 15
name: "Linux NFSv4.2 DERGINB0666"
minor version: 2
Implementation domain: "kernel.org"
Implementation name: "Linux 5.10.0-22-rt-686-pae #1 SMP PREEMPT_RT
Debian 5.10.178-3 (2023-04-22) i686"
Implementation time: [0, 0]
callback state: UP
callback address: 93.240.185.34:0
---- snip ----

How is this implemented, e.g. what does a NFSv4.1 client have to do to
send the nfsd a "Implementation name" string ?

----

Bye,
Roland
-- 
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /==\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)

