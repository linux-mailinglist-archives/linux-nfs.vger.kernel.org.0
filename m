Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD9226BAF
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 18:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgGTQn3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 12:43:29 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:55129 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730000AbgGTPmC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 11:42:02 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jxXvT-0002eg-Vs; Mon, 20 Jul 2020 10:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4rCNOkqd0GrW+e4CDSgN3Fb40GTvjJ+sqo6P0UtbHwk=; b=hbq9b4R9S7ZF/G5VCQB7suF2Nf
        eHC0D9d+e24QGleZhn2ZQV0uILjyyNMARgIOcbOAo35zykxrviEeZWAd/jU9AV/EydIkVwV00z6OO
        JiahOyuVW7H/VnjJ8n2z9ukjtj8oz+A8xYi7JGUXXmYJBx6VtAed902+b51ZXhSIVLnktU/Fg/7LI
        Hq4sujcwPug7ffLQla5M8OF/1B/DHkKLSLaEZeAK8kewImk7riYn2smRabIxskYnFzW6KUgDL8VWi
        0f2MnbEdKEkCXlAR9m1cgMZwNOcgwKYpxIXJDpamge4cZ32XsFfX2KiOUYRAR4OKPzdZtq1MtXFUl
        jOwXwCVA==;
Received: from [174.119.114.224] (port=54261 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jxXvT-0002iF-JP; Mon, 20 Jul 2020 11:41:59 -0400
Subject: Re: [PATCH 02/11] gssd: Fix cccache buffer size
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200718092421.31691-1-nazard@nazar.ca>
 <20200718092421.31691-3-nazard@nazar.ca>
 <fa7a464f-3749-b8d8-bf92-02173a03dffb@RedHat.com>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <8b2a9798-7c46-9509-1e78-4101fb901252@nazar.ca>
Date:   Mon, 20 Jul 2020 11:41:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:79.0) Gecko/20100101
 Firefox/79.0 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <fa7a464f-3749-b8d8-bf92-02173a03dffb@RedHat.com>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVl6gnFZArPu8o
 hDwIoaacHkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTibW
 aG5S00Ke4iKnmCsTdmJlcUeN/JW8E9PaHbmUYGTMTX+DNB8zzxX/4FjqtJmb5CqPXWZ3Q04Sknss
 PO87zpIBzS5fPHINUJxVzZg1ZLp9WsNs/TiGk4ran4P5akI9/iSD+AOQ3aTXsOlBj1rS7KuJKV22
 DmcCOObp+EfB9TVxwAQsq9Jr0hwdTzDySvwsAZ57yox544FFkGIGo/UPEJklPZ+d+6dQltnW35dY
 HDi4YsOSYzzrWOkGpzUJhy0xLBRKoVbdmzfZG7WP8P7/emcDFPZI3xOxBaPpD+a4iBFJkhqbiTdT
 lYcOHnVgVGtCG6MIpAaBCnEm0QC5cIoZWwuuqr0aikOvJA+DuzeF4b+ym3AhG426mliYkCHBZpOg
 oqc4uCQ1hIibn+MrIDYy2WDv159KWP8Flu8XxG08DxyID4UUr5AMi9bhRLAI2wpnnpu0VYQwuqxm
 ozzkDLIpUMoGSJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEG1qwIZ2MQhDb0Rn5TCwHWbo
 CpfPZNiBFnD7oJ3lzlHo7tKmnBRRVxmZVTuvC1DyVQeYUOp7A73HI6oJg7w/Vod3QTO7QTL/vMcL
 queBWI153jp7haOSLlxw44w9I2ZifS32EoSnB0KQ6B3xt8UP9IqiIoZ5y2slXm/bJtJoELtOerz9
 cqOXWO4+PQeXdSLIvTnR+x7N1q5mHvGiTT7cMIhGzW5mmjGyg8okvrmjmhIectgzcDoFd+96Xw4Q
 UNtTnaqKMELGl6tE0K+BcrxAjOpojt+2wgmoPg0r3fLmjzUcOV+CuA5GimAT6h9Ujgm5ShD2vvTW
 dasCwvCiFabvBgs1Q2yTITNEqokCKaRTOpRi1i3DxpeppJLPqpIzQH91oWpnoGrsoLVX4uRIcZji
 Lua7QDsLZwFcOTN1VL7o22jDHzxYOOo85NMG/uIDWvq5VedjXZBNOJeqVzGgrKtR6HA=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-20 10:43, Steve Dickson wrote:
> Thanks for point this out but I think I'm going to go with this:
> -	char buf[PATH_MAX+4+2+256];
> +	/* dirname + cctype + d_name + NULL */
> +	char buf[PATH_MAX+5+256+1];
>
> which explains the needed space and as well removes the warning...

That's fine. I didn't spend much time wondering why it was written that 
way, just assumed there was a reason.

Doug

