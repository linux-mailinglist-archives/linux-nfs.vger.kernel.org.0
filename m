Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA2B20A800
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404390AbgFYWLR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Jun 2020 18:11:17 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:57455 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728541AbgFYWLQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Jun 2020 18:11:16 -0400
X-Greylist: delayed 1615 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2020 18:11:16 EDT
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1joZfM-0003Wg-KD; Thu, 25 Jun 2020 16:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5ZaFD8xwGGh4ZdyibW8EjPSLF0QDDusZLmEjDbPyi78=; b=OX3kCdRenmGp43LlcV9wzVy9VJ
        lZhBI2x2o96VtqRmARrKpD5yqdopRr4vUh1mHUV6c6A1ZfDfW0Iavq3AcYwac5amsE8LglwbN6KOf
        XjQOXQgq55UxU1wCOzNOQ83AywmKqoCBRRdZ/IVdB+mDgUUIjyIbJmTHhNOJhW2uA3s3k9GBd+RGz
        7rwOUpgpuq1HLRtnI/hQHUxgMsuldjsoqxRQrN1X9IFpk5dUeLRdvWT11TtO068mUHrFgcdixJUV1
        BmMurk8CD7DagcujhQPkixy5/wTLQIXIjBKzRo+fRLAn16EPFJjQ2L4FcJkCyRVMl5vFRaUNtwbCp
        RA91NBog==;
Received: from [174.119.114.224] (port=56455 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1joZfK-0001pV-T3; Thu, 25 Jun 2020 17:44:14 -0400
Subject: Re: Strange segmentation violations of rpc.gssd in Debian Buster
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <af85fe766d734e3ca389ffc8845e4a0f@tu-berlin.de>
 <20200619220434.GB1594@fieldses.org>
 <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
Date:   Thu, 25 Jun 2020 17:44:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.13)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVn0pr/eWrXTid
 XTJ2Y50JtUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTpHR
 3t4R4vw0+gs6rQMezuDQdD3ECQyPVYuo/ujzNsc8V72ZlMoYFW/iILNesMKWB6DY4cCrsCyAwHoj
 HGSwEc8CUhteWi9sZ0/D91cArp6Aaq2N3Fs371WfzRtGJWrwKAK/NzaQ0kU5LIjXaSmvljwhyk8Q
 3euhueWKWlOW4QobXxusReGs8D5s+BpOoqsKPHnEEeQIwKMymizPrn975/qMR6RnXDqOz0oQYKSM
 2MZ1trSG+zanhVH6MyN4UABWXkpCHkq3t2QWc5y7R2vgTKTvxnrnHtOKPp7r4O3DezwNkL/+h1aL
 2OqtpSX2AHJEJUCbUeEMVjDon5rfSznEF9Wn0xds8xzlI9bNNBd60UaaLFOTFOSXhInfKu2LaPOi
 g0Tz8DRKXZMehWGgJjrhqyz6Bfy1T3PwsUos1yNYdTOG17NirEYyqwqMBGrw8ELiqOQm0t959gAh
 KvRa1vmpN2P40gxJLR2O3anAdXM16WBTRUFUU5/JtLKKEUu4esXRICk4xAm9D8KTeKJT7gNACPd+
 nNEjPOAcc2mSKil38RhC5WpVRRy7ey4Vrj8oN0DwH5zchTwz5HNHuVi9qs3XQ4gnJC8t6+rWfQsb
 10XcAoxwQk8w+7owm6K0HfhUbV86k35e90wcVfDxixi0L/Em6K0oqBBzZqz34WAUSeMDkO8xLypP
 fi/26oO2cauHDD/6kTRqq9XJ3A7TbtUilHMjAbMQ9r701nWrAsLwohWm7wYLeHkNjfXxRRqyRbYy
 SsHpHKadYLixxWRJdjXT5NXOLDAccBIk1Sag4dKiqCrF8eZZ3gAFgf5pxcvjqhYUkJ+PVcagBWhr
 PqYGcDoUB+MVMogTqfDNG/eSEDCU3zUmlBVgZvOugleMfvBA1j+Q7fKKz3fccSHpoEA6x1E6NCAy
 03IIEaw2FATNOSyR0hlRJ2bU83KrEXc+Z1DahbUFzBX4rvXS1+qgaVt1ORMtpYIBctpo5lIZ42Pp
 IMd67+j9MC/iEbKoMM0R+bccIbn7fCdCag==
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-06-25 13:43, Kraus, Sebastian wrote:
> [Current thread is 1 (Thread 0x7fb2eaeba700 (LWP 14174))]
> (gdb) bt
> #0  0x000056233fff038e in ?? ()
> #1  0x000056233fff09f8 in ?? ()
> #2  0x000056233fff0b92 in ?? ()
> #3  0x000056233fff13b3 in ?? ()
> #4  0x00007fb2eb8dbfa3 in start_thread (arg=<optimized out>) at pthread_create.c:486
> #5  0x00007fb2eb80c4cf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> (gdb) quit
>
>
> I am not an expert in analyzing stack and backtraces. Is there anything meaningful, you are able to extract from the trace?
> As far as I see, thread 14174 caused the segmentation violation just after its birth on clone.
> Please correct me, if I am in error.
> Seems Debian Buster does not ship any dedicated package with debug symbols for the rpc.gssd executable.
> So far, I was not able to find such a package.
> What's your opinon about the trace?

You'll need to install the debug symbols for your distribution/package. 
A quick google links to https://wiki.debian.org/HowToGetABacktrace. 
Those ?? lines should then be replaced with function, file & line numbers.

I've been following this with interest since it used to happen to me a 
lot. It hasn't recently, even though every so often I spend a few hours 
trying to re-create it to try debug it.

Doug

