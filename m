Return-Path: <linux-nfs+bounces-2448-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349CD88771E
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Mar 2024 06:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FC8283CF1
	for <lists+linux-nfs@lfdr.de>; Sat, 23 Mar 2024 05:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FF146A2;
	Sat, 23 Mar 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agFz0i/P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202E4683
	for <linux-nfs@vger.kernel.org>; Sat, 23 Mar 2024 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711171515; cv=none; b=IETijDHHEL8N4M91MoVkMtH3P+tAOIWlGzf4YQxAtsoYe+3iBbQkq7TiHnS9PpewIO7m0xX5lzvhJnNSHFGu99BXfb/35DA9wSCkt3WhODDHbzGE+ZtjZ4ablL7eF8x1pbEIsD3DwDNBl8Apvh4oF34uHBCvCtj3JgyFTSy7opY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711171515; c=relaxed/simple;
	bh=kY+6y1ow7mqkFowZOQHLHF9Kbx5EAcrLrRAXceacESc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQG5P8vXn1CbLSz4MSuiMm+04pIjOPuYesbM3uaqa0MIHG3aMwbh57aX17GnJ+qmzjy4rgHb9z7RlR2Gt3PbNDq4wVfvVmaJk66fbMMrVfmRwH0qXSPg64NtWp+R5uYYkkGdh7gj3f3wfm3g+RboioFI7cZqXB4ayJ0+tCVqGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agFz0i/P; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso2547a12.1
        for <linux-nfs@vger.kernel.org>; Fri, 22 Mar 2024 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711171512; x=1711776312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWwusHc4g5K0vlYfrxCxhqyKdqyqPaae+x/aLX4gMjY=;
        b=agFz0i/P2d3vh7e06l/f5ZigqjtA4Db/AD8RL1L+2ybheuvAvGX2+98iJrn5JBOZgC
         ew5cO4uNPFBzgI+thqK98Z4lv72+LFIboaZq7oa5BXtgtFUB0XXQdWY0emBfeARY/Dyu
         /vvhURj8Wpfrf9W9Pozsrbv0LPS2DVkCfNHHzEu+9sQsbeRPVx3pYOQo4cwSbIvnuIgi
         Yf1E4Whu9xZVKC72VbqllzMsRrjNO277HlYjiy2nzLKdcB/oHt4RvtMMyklHa07D3iU2
         Az/RPqRwnn+HTcAqdkEMVSlv5MR5YzAGrecFbDlo9u9qBpBPj/AK2AeXAFWuIW5XjqjX
         bNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711171512; x=1711776312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWwusHc4g5K0vlYfrxCxhqyKdqyqPaae+x/aLX4gMjY=;
        b=RVr3cqnJYWn1pUde37isoU8mqDvTriOUm0/fz5L/QE0X5ISSg8XkmGJOHbg0IFCSX2
         i69SUTswslOtPAumrOQgRNm8nJSMMiMfoJ+SUeIPvUi6HWYNP0dhyYdR2GdQqzZEtQhg
         7tzIaNP3IbnTe59SXvH9rK8g7gscedPIZ8Ydm9t4Nav86ODlFR/2PZXSwgbEjol027XZ
         xMcNr2OwWY4/6cMPAcAtepSwKSbeMt+GU5vgYR9PExB7+e9aQQQd0uhcvLeC0yVeVjG/
         pnFciiRYFL/cO3HksiJQR83obfNtdTYRNso+sWbwDv1981bd9uPwEQ9e5HfVCuUxmYaT
         UI9g==
X-Forwarded-Encrypted: i=1; AJvYcCUUet58/1bENuXxi+AIXbTHBGxb91H0vDL1AmfXB/tgpLjltxB3V22KhcJmJR+pzSvVjFXX69OaaMA4C4sLG8e6CdO25rt5QORV
X-Gm-Message-State: AOJu0YwamKzn1hBKSeUxlnXBnhLLNM+sFv2er6g6NS8MntawC5YRyTum
	C1HwIEm8a4n5lxeu+Ijrj175TCcJPaXTYQLQqF+q19qeiSnH0O86F1n10eeYfSSfVlN4uAaMz2f
	cLxWn55afdJcPKwg7oYU/q1YzIeqVSUP1xMFT
X-Google-Smtp-Source: AGHT+IFl1L5BjiFh8QUkB8MwquRDhvH1hPnYrMfRfn1Rn3l45FM1iX2TyI5SLvvoArrxKZ64cGEFI4GBa9BUYovD2W4=
X-Received: by 2002:aa7:c842:0:b0:568:ce1e:94e5 with SMTP id
 g2-20020aa7c842000000b00568ce1e94e5mr491838edt.5.1711171511708; Fri, 22 Mar
 2024 22:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA1CXcBqcyXma1kGwvfAQ5T24dmuH_Or9RPrVqxDoVq=N4Se3w@mail.gmail.com>
 <20240321143200.1854489-1-smayhew@redhat.com>
In-Reply-To: <20240321143200.1854489-1-smayhew@redhat.com>
From: David Gow <davidgow@google.com>
Date: Sat, 23 Mar 2024 13:24:58 +0800
Message-ID: <CABVgOSmDJpU7km5em_WbY1A04f+AF74a8_4GccjrJk1nW+1Fww@mail.gmail.com>
Subject: Re: [PATCH] kunit: bail out early in __kunit_test_suites_init() if
 there are no suites to test
To: Scott Mayhew <smayhew@redhat.com>
Cc: brendanhiggins@google.com, rmoar@google.com, npache@redhat.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-nfs@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000021f49a06144d2a72"

--00000000000021f49a06144d2a72
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 22:32, Scott Mayhew <smayhew@redhat.com> wrote:
>
> Commit c72a870926c2 added a mutex to prevent kunit tests from running
> concurrently.  Unfortunately that mutex gets locked during module load
> regardless of whether the module actually has any kunit tests.  This
> causes a problem for kunit tests that might need to load other kernel
> modules (e.g. gss_krb5_test loading the camellia module).
>
> So check to see if there are actually any tests to run before locking
> the kunit_run_lock mutex.
>
> Fixes: c72a870926c2 ("kunit: add ability to run tests after boot using debugfs")
> Reported-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---

Thanks, this works well here, and is a good idea anyway.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/test.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 1d1475578515..b8514dbb337c 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -712,6 +712,9 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>  {
>         unsigned int i;
>
> +       if (num_suites == 0)
> +               return 0;
> +
>         if (!kunit_enabled() && num_suites > 0) {
>                 pr_info("kunit: disabled\n");
>                 return 0;
> --
> 2.43.0
>

--00000000000021f49a06144d2a72
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIFwa5VuHaGMKqh3bMk2XHqLqSZgRKDH31/GvWtaMVQ3MMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyMzA1MjUxMlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAj4CCg
EJ8DE7Vt+E3qOJBc4BOoVsByb5X3ehXlWmqAk8WMImK/CNXw+LlPYwnqZ5LIp8OrjaLUHMY1Gkma
9RrjvjEFPCjt6mxF+7ZEe1Vx3Z9UlsCKC/Z05D4TPbXaY7nDqcAyUrk/ys03gRfGHzPRgXJgk8Na
hq+QqVVCfRwQ3mgKA/XjJxhaz9gQDUaBFAFywTKW48dsIAuvveItorD2/dF+W+0T9cOHTkiuj9Qj
3xC1cjVpxH52Ox4fmF9CJRXUYlzxYacgu4SniY+bCjvM3vq4rLSO9FPg2+G76TWNlUgeYhBL6tsZ
hEKMGOhQlQ1st3bfSqYRi9gi5p8N3RQz
--00000000000021f49a06144d2a72--

