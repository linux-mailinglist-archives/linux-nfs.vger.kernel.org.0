Return-Path: <linux-nfs+bounces-5784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945F95FCDA
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 00:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED151F21B03
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 22:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBF519B5B2;
	Mon, 26 Aug 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU8GyZMz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34319B3D8
	for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711956; cv=none; b=SDUN4iH8Wbwnwe98L4hoviRA6cxKSDL9wFwcIuICBfBBq5SXlgDSmdF3Oz46AQHg78MSU6EH3B2V4/FalsmvrPtm2OL+01/q8/KPDDrcCjzGCr3sFjKo++wweidQnHurxHVEnzr4kUE4/o79IvVM8fR0izXhnrx0mAXQa6/seCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711956; c=relaxed/simple;
	bh=r+wvwsO22rxqeLloLfFI/vptKVbtbY0a8E4Z6rqqO/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HuAJfiUTKCoEgsLKDUkTF3euJK1vn0NhGlCnEFfzM1heakilubOdwYKOf/FInBBoCp5hBI6qMdNMZtste+891CncIeu/gXD+ivspUWbCTs7gwtbg7yYko2wnQhDKIorkAfiPzW/kc+ULvHMh2FaMqOiyxCPuyM7NMuwZkAXeMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eU8GyZMz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo2854896a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2024 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724711955; x=1725316755; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SGPBGJaXZMF7RfGVt9KC7TCYX2RmJBbr6TPfh1PNcRg=;
        b=eU8GyZMz4xIw2+68P6XN+oaO15Oo1pGohySvcqPtTaq5Q1DGJSFw2gc7k9iawO+N2h
         3NeBpUhMQ2xVAFW0roeb+Y4xWWEYLeL+nWHLP5undTJxXbcTS69OkRn6H99VQMpGgUfe
         Ubvr8UT8TXjib7NvWBSukG+laBEwvVKZk6kdknBH1hEp9XWaFEqTSlaz/bz7ToXORq4B
         rQ338AQrwHJOAwEBRHINFH6UcLV0LDjSqcsz/SydS9eaDo3PM/Fo1X3tn1Qvs/C30Jq/
         84i6SVE2JDRdyXz/4ySXCGhp38MFNmLXbkmy+apt6H7O45M95Rq7fp5v3mCLUxTyNRxo
         DIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711955; x=1725316755;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGPBGJaXZMF7RfGVt9KC7TCYX2RmJBbr6TPfh1PNcRg=;
        b=IuUwDNLXtBH5Wedj7I4jRlJoNMKIrarFKxRN+gxYa8od5nk5LWnQuSNv29ad2OKwT6
         vyxIeFG/f3tJecaKQKn4RlTn36FFNs0QWxTpctA4Uxej6F8W1JEa86zjA23kVUxKSC8C
         wDh7lkHGMAHmAXgobrZVkwexXqeQ+itAa43dPV8zY4BsohkPEX//8+a4AZn/8eBfMcGq
         6r4DsPG1MnRt94f77avh//90viOile9k8Pb+QbQ3yNUduE82hwRkSv1d4dwvIcR8edCe
         QAkB0OYIttTUBXvzKOVUOvAzsTWcJ9nn242TBYQOovUDPvvg3drvkgcAsyEEyEbn9y5x
         /AoQ==
X-Gm-Message-State: AOJu0YzGIax85fEuI3i3OfnCm8NNmiHDi9HdJcke8PR/tXk2ExPWwS+H
	B+GCKGxkf7OB5UznKlzKwhcq/ll3XDqPHWaHLjhLyVt3IfIXO6H2r/XlbYGvCv5GxJV9XchZdU0
	DiY7rYxv52u/Hv4SQEw9tkTnu4Al/ze8=
X-Google-Smtp-Source: AGHT+IFUjRWkIs54pnU+XAUPZdV6LTCjKN2g0aM3UJ7L2+4OESd245Gk/qvB5aicJZRha8DrRCbiXy0VriU5bSa7ODs=
X-Received: by 2002:a17:902:d2cc:b0:202:11ab:ccf4 with SMTP id
 d9443c01a7336-2039e442d21mr120235825ad.6.1724711954557; Mon, 26 Aug 2024
 15:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rick Macklem <rick.macklem@gmail.com>
Date: Mon, 26 Aug 2024 15:39:04 -0700
Message-ID: <CAM5tNy4YpKiV0oLkS8o8Pj7-swV0xXX+JnyF4o9A9Q0dB29Biw@mail.gmail.com>
Subject: Re: Linux NFSv4 client patch for testing of the POSIX ACL extension
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> This one may only be a configuration problem, but even though I think
> I have the uid<->name mapping working, nfs_map_uid_to_name() always
> returns the "number in the string".
> --> To get setfacl to work, I have to configure my test server to use
>     "numbers in strings". (nfs_map_name_to_uid() does seem to work?)
Btw, this one turned out to be a bug in my experimental server. It replied
NFS4ERR_INVAL instead of NFS4ERR_BADOWNER when the "digits in string"
was sent in the POSIX ACL's "who" for a SETATTR.  Once the server was fixed,
it works ok. (The NFS_CAP_UIDGID_NOMAP bit gets cleared and it works via
a retry.)

rick

