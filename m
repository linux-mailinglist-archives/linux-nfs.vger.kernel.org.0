Return-Path: <linux-nfs+bounces-5064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB2E93D03D
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C6B28308C
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6312F176248;
	Fri, 26 Jul 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dockstudios-co-uk.20230601.gappssmtp.com header.i=@dockstudios-co-uk.20230601.gappssmtp.com header.b="nme5LblG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359616116
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985305; cv=none; b=i3Fx8Q/omk2rjiGa7825DNx8d2oxqJFyjRllrh7pDAZVh6oV43/A3/E6obfFFBkaQ1hzW8VvG3IRUQJHrZ2YShhuV8lDwcaEybGUHNKNRbXEHqobofZU78NcNqMe4XwVkXBDuLcMskxRdiv6V3yUxCXk/hGV4OIkhY3NGyvVLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985305; c=relaxed/simple;
	bh=dCJxi0CVUqEEgW+a7qNPTXUOpa3n1YHpjQCfF9Y5qMI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KqIPlyDgxVdxi+ySGg5nyLjYncEMcxVdofy2sG9E20ci5zgLAv0d1rjX+zsUUPIkbBIWGyjS8OOjQaPjOtu4zFBU7ubzANFBthbtl7K221xocxSJMGP2XrYHmsGDemqC7oULoIR8x7UIVUfGMDI8VTEmhV3pJ/B+2m4n5LGkN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dockstudios.co.uk; spf=none smtp.mailfrom=dockstudios.co.uk; dkim=pass (2048-bit key) header.d=dockstudios-co-uk.20230601.gappssmtp.com header.i=@dockstudios-co-uk.20230601.gappssmtp.com header.b=nme5LblG; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dockstudios.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dockstudios.co.uk
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-260e6dfc701so656453fac.3
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dockstudios-co-uk.20230601.gappssmtp.com; s=20230601; t=1721985298; x=1722590098; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j2rfP/xDgs1zg4f5gzzNa3jqP+W1+Ialrc8dUfelhp4=;
        b=nme5LblGQ3RnTBqtmgjBz8WuVeAXvkTaLQku5ltbFbpHXIYh6xxuGIqYUoBDn0gWqv
         Z3PJT3FkBXhkg6QB+9fpoIhjxUaxEEaOplurild6kOZqjTCe6mGh66yWuAnF6jwMi+yq
         5i46XeY5xqBUY+0x5wQJRZ6oiRPfQPBgUGRKoveoUSrHL/t9NOU3T2xFdwX48unHhGM1
         0g60wY23zxr8dmx33z2VrtJxBvCQTEc8x7uRZb7CZel/dDTIceRp+y6jjcJ+RADUjtCk
         /1RhSCaevCFrkn67pGCvNZEtloDmrQJGCM7DcjQfOCdVgMT9UsHVEtFPzCKpmzhNngO7
         +v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721985298; x=1722590098;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2rfP/xDgs1zg4f5gzzNa3jqP+W1+Ialrc8dUfelhp4=;
        b=TWQnwGuRLfFBNhrY90txivBeHwJR6S1ePBoo/SW+saBtsXQoutYRxy+NTwD89Zxsyr
         V1TfOYd92ofPRhvqCjdrY2PGAyYVZRDJUh8/zG3ltHLyU+fG1pVsaVmLi5iR85IXmUiV
         x0IxR9e5Mxbm4zWRblWKfkB9TkeOgazWTV2ZBrshCU77dosIXwY/HlcGgnim+Q4A2GQj
         l86YwP6FjppPiabX5K1N6sFTdvQKZuqYBkE0wQuHDmZ24VY3ycQdI+6W38/OLFOhNlrS
         IbylqM74ymA9rfJ20cpXG3sBOHe/kRJI7fJDoCXxV1fZ4tHYICtAmYMxmHroV2IgJ4rE
         U9Rg==
X-Gm-Message-State: AOJu0YxvMLHggBkSRxSSP1jddcWm/C4HPWpMB2nQ2hbvOM0fm5P1IauQ
	5gtw7Iaz724bQjjV1Rg9UyXVlZqmULgoXVBH/gvKJGkYO19Kf6OLUzuomNse8GtBJmvxq5xAbVa
	0RH6fKh5mk0eqS/a00Pr0Zka/dsKNKXIyJHAyJU8SEzTvySZHxHQ=
X-Google-Smtp-Source: AGHT+IEcXVIzoFb4eteemNL8YKGJ4cFvKT3YROlXHnZ0yj/amB5OVaz/S9ZSD7gRS4nR7n7uXbBQGODE3ZfOd9ngWws=
X-Received: by 2002:a05:6870:171a:b0:261:86d:89e2 with SMTP id
 586e51a60fabf-264a103a8f7mr5505299fac.36.1721985297954; Fri, 26 Jul 2024
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Comben <matthew@dockstudios.co.uk>
Date: Fri, 26 Jul 2024 10:14:46 +0100
Message-ID: <CAJw_U8fKkq25Ft_82MasFA2WQLHh4Vv+8af7DfHFbH6R0KmF1w@mail.gmail.com>
Subject: Patch for small typo in nfsmount.conf
To: linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fe6f67061e22f184"

--000000000000fe6f67061e22f184
Content-Type: multipart/alternative; boundary="000000000000fe6f65061e22f182"

--000000000000fe6f65061e22f182
Content-Type: text/plain; charset="UTF-8"

Dear NFS maintainers,

I found this small typo (and appreciate it may seem like a waste of your
time). But I've prepared a patch to correct (as I currently interpret the
comment), if you are interested in it :)

Apologies in advance if I have prepared this patch incorrectly - I did no
see any specific information in the "about" of
https://git.kernel.org/pub/scm/linux/kernel/git/rw/nfs-utils.git/about

Many thanks
Matt

--000000000000fe6f65061e22f182
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear NFS maintainers,</div><div><br></div><div>I foun=
d this small typo (and appreciate it may seem like a waste of your time). B=
ut I&#39;ve prepared a patch to correct (as I currently interpret the comme=
nt), if you are interested in it :)</div><div><br></div><div>Apologies in a=
dvance if I have prepared this patch incorrectly - I did no see any specifi=
c information in the &quot;about&quot; of <a href=3D"https://git.kernel.org=
/pub/scm/linux/kernel/git/rw/nfs-utils.git/about">https://git.kernel.org/pu=
b/scm/linux/kernel/git/rw/nfs-utils.git/about</a><br></div><div><br></div><=
div>Many thanks</div><div>Matt<br></div></div>

--000000000000fe6f65061e22f182--
--000000000000fe6f67061e22f184
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Fix-typo-syntax-issues-in-nfsmount-config-comments-a.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-typo-syntax-issues-in-nfsmount-config-comments-a.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lz2hjeve0>
X-Attachment-Id: f_lz2hjeve0

RnJvbSBjOTkxNDA2OWY0ZTM5ZjI4ZDlmNjgwNWIyYjNiZDhhMmVhYzQxNDY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0aGV3IEpvaG4gPG1hdHRoZXdAZG9ja3N0dWRpb3MuY28u
dWs+CkRhdGU6IEZyaSwgMjYgSnVsIDIwMjQgMTA6MDg6MzAgKzAxMDAKU3ViamVjdDogW1BBVENI
XSBGaXggdHlwby9zeW50YXggaXNzdWVzIGluIG5mc21vdW50IGNvbmZpZyBjb21tZW50cyBhYm91
dAogbm9hdGltZSBhbmQgZml4IG1pbm9yIHdoaXRlc3BhY2UgY2hhbmdlcwoKU2lnbmVkLW9mZi1i
eTogTWF0dGhldyBKb2huIDxtYXR0aGV3QGRvY2tzdHVkaW9zLmNvLnVrPgotLS0KIHV0aWxzL21v
dW50L25mc21vdW50LmNvbmYgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS91dGlscy9tb3VudC9uZnNtb3VudC5j
b25mIGIvdXRpbHMvbW91bnQvbmZzbW91bnQuY29uZgppbmRleCBjNDk4ZWI4MC4uZDhlNjg1YWEg
MTAwNjQ0Ci0tLSBhL3V0aWxzL21vdW50L25mc21vdW50LmNvbmYKKysrIGIvdXRpbHMvbW91bnQv
bmZzbW91bnQuY29uZgpAQCAtMTMwLDE1ICsxMzAsMTUgQEAKICMgU2VydmVyIFBvcnQKICMgUG9y
dD0yMDQ5CiAjCi0jIFJQQ0dTUyBzZWN1cml0eSBmbGF2b3JzIAorIyBSUENHU1Mgc2VjdXJpdHkg
Zmxhdm9ycwogIyBbbm9uZSwgc3lzLCBrcmI1LCBrcmI1aSwga3JiNXAgXQogIyBTZWM9c3lzCiAj
CiAjIEFsbG93IFNpZ25hbHMgdG8gaW50ZXJydXB0IGZpbGUgb3BlcmF0aW9ucwogIyBJbnRyPVRy
dWUKICMKLSMgU3BlY2lmaWVzICBob3cgdGhlIGtlcm5lbCBtYW5hZ2VzIGl0cyBjYWNoZSBvZiBk
aXJlY3RvcnkKKyMgU3BlY2lmaWVzIGhvdyB0aGUga2VybmVsIG1hbmFnZXMgaXRzIGNhY2hlIG9m
IGRpcmVjdG9yeQogIyBMb29rdXBjYWNoZT1hbGx8bm9uZXxwb3N8cG9zaXRpdmUKICMKLSMgVHVy
biBvZiB0aGUgY2FjaGluZyBvZiB0aGF0IGFjY2VzcyB0aW1lCisjIFR1cm4gb2ZmIHRoZSBjYWNo
aW5nIG9mIGFjY2VzcyB0aW1lCiAjIG5vYXRpbWU9VHJ1ZQotLSAKMi4yNS4xCgo=
--000000000000fe6f67061e22f184--

