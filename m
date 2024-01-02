Return-Path: <linux-nfs+bounces-854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8172C82160A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 01:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BDE1C20E2F
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CB0363;
	Tue,  2 Jan 2024 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2r+swrp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3C36A
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jan 2024 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so10717337e87.3
        for <linux-nfs@vger.kernel.org>; Mon, 01 Jan 2024 16:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704155988; x=1704760788; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UG6oPVzZiQMmmVewlZnoS7Nc/NdSf5wahxkY6QwDkk=;
        b=Q2r+swrpYFPI5NdHef1M9edmwfUoTkc48FXzQcxHm7tVPte58Rj8ACuI1rDvDBtV9x
         NH8IpPJphlMdxzmebxCleEOw9wmzC96xnN5HtPg/Ec12yOo0KHHpTQ67ZmDdTMk+Ots6
         aQv/skYl3o1mOKf5DJQjMOjGHuIwsw06c948VhZbF+S2lBvRqVpiMQIMgxeJkEfzS+EH
         tLEpU+u0+BgYEBuC1X2/0vHoTIY79pdsxNqqMoBUp3AbPvY3XQZTuI6q7Z9Yk0YxKNgn
         g27b3wZAgn4Ed2GMTqPw1oNdVOc5DwlXxORqdupumedstUaGJQnIgt1P53mdJVbh6146
         gGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704155988; x=1704760788;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UG6oPVzZiQMmmVewlZnoS7Nc/NdSf5wahxkY6QwDkk=;
        b=T4sdnD34cbnAqSRlDFeTN7ca+dh49xv8YPEQ9ZbwJUXeJUb8dDz/XYhOEBoJHJrolY
         puOtvLDl7ZT09dV8K8BpWL0LyE28FfYYu2bn/6fw8SEoxM3Nt1B4dXRQMlWui+g1Q3mE
         H5vyhxED2hYou0hzV+4+j3RjhE9iGrAV62co/LB91FU8XnFemf2BYgvKShxuxQiKyS15
         gcGD1wpfC/p3t7GTbMCdTUmeeRpmyAA4Jq8GCUuS2hQ3+6D10gcKNi5x7gdmSvfx403f
         kuseIeDi/xl6z+VBtVdc8bwBkaWhsJS6fPBszEu6V/y9Ms98PphpeMaZ+PrVu8/V90wx
         zcNw==
X-Gm-Message-State: AOJu0YzTLi++xmQm/a9tMwP8cUYlJUeVHGEYRpTI4ZHmhBZxEEIgTGJv
	E8zO+Xo2G110jLJxzd7OFgcJ4hlHeVW1ap6vaDRzZ9rO
X-Google-Smtp-Source: AGHT+IFCadGwSyd9osV5yoi5B0gaNS4Sjn2hxc8nkFzDyN6kVX4gNdzlNvR8Q0IKzY1TVE1ve+79a50iUWRqcYv+d04=
X-Received: by 2002:ac2:55b8:0:b0:50e:554a:5254 with SMTP id
 y24-20020ac255b8000000b0050e554a5254mr6244694lfg.13.1704155988603; Mon, 01
 Jan 2024 16:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCNcA9R5ChZ3pXN689A=pZ_bffX3vZRvk-DUsSgT2WW7T2Fg@mail.gmail.com>
In-Reply-To: <CAAvCNcA9R5ChZ3pXN689A=pZ_bffX3vZRvk-DUsSgT2WW7T2Fg@mail.gmail.com>
From: Dan Shelton <dan.f.shelton@gmail.com>
Date: Tue, 2 Jan 2024 01:39:22 +0100
Message-ID: <CAAvCNcByc-qNeNqT-0YeuiyzEpBY79=VjVdSFDh+_hahWGEtgw@mail.gmail.com>
Subject: Re: Linux NFSv4 client: open() AlternateDataStreams via ioctl()?
To: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

?

On Wed, 6 Dec 2023 at 04:33, Dan Shelton <dan.f.shelton@gmail.com> wrote:
>
> Hello!
> We know that Linux will never implement AlternateDataStreams, but as
> we need it and need access to these data, could the Linux NFSv4 client
> add a ioctl() to request a fd to an ADS?
> --
> Dan



-- 
Dan Shelton - Cluster Specialist Win/Lin/Bsd

