Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7577A2265E8
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jul 2020 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgGTP6h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jul 2020 11:58:37 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:44035 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732055AbgGTP6g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jul 2020 11:58:36 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jxYBV-0005Pb-Qa; Mon, 20 Jul 2020 10:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zxccq99QrKl4znlY1rWlCmjgog7QH+l3AejzQhf5YQI=; b=IpzKNSYSUN1BQKYxDa1qJTtdL9
        VZpZEyFq0v5ou1/NtUuIEDgxKuaYOkFg/h3v/adkbD5glT1uQAYfBFREp/ArOBQ+qcqBTtHbUZSGM
        PczMAZnFa/65QTbWn7lu4Ne1HXpibHaHp/uLy0cKxaKXGGQx7fQRigABKe4rHicmXaSL31YdeiUgi
        6J9JGIn3IkW2E1d8tYgjy+cbhggPr40ny4MRJtkBABuXJxrzkzgFbJwyBcEd73LiajiwhYpsjJTNe
        Nynw5NMD9V5mcJs98DYVVeQ0B1w3/sBVuj9mmMZMTBNe6sFnNthLj+0vwnSTMu3r/1dtvVhvf+Y9E
        nWfv2YqQ==;
Received: from [174.119.114.224] (port=54383 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jxYBV-0005Vp-Hz; Mon, 20 Jul 2020 11:58:33 -0400
Subject: Re: [PATCH 09/11] nfsidmap: Add support to cleanup resources on exit
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200718092421.31691-1-nazard@nazar.ca>
 <20200718092421.31691-10-nazard@nazar.ca>
 <84277cb9-03da-3065-1848-f8c1e2bee167@RedHat.com>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <568e0535-e20c-80a9-a0c7-61b3656f997f@nazar.ca>
Date:   Mon, 20 Jul 2020 11:58:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:79.0) Gecko/20100101
 Firefox/79.0 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <84277cb9-03da-3065-1848-f8c1e2bee167@RedHat.com>
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
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVykNZlnTrJFAq
 LJkm8zF6LETNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTibW
 aG5S00Ke4iKnmCsTdmJlcUeN/JW8E9PaHbmUYGTMTX+DNB8zzxX/4FjqtJmb5CE1GpJwCv2PML77
 7S6HRlIBzS5fPHINUJxVzZg1ZLp9WsNs/TiGk4ran4P5akI9/iSD+AOQ3aTXsOlBj1rS7KuJKV22
 DmcCOObp+EfB9TVxwAQsq9Jr0hwdTzDySvwsAZ57yox544FFkGIGo/UPEJklPZ+d+6dQltnW35dY
 HDi4YsOSYzzrWOkGpzUJhy0xLBRKoVbdmzfZG7WP8P7/emcDFPZI3xOxBaPpD+a4iBFJkhqbiTdT
 lYcOHnVgVGtCG6MIpAaBCnEm0QC5cIoZWwuuqr0aikOvJA+DuzeF4b+ym3AhG426mliYkCHBZpOg
 oqc4uCQ1hIibn+MrIDYy2WDv159KWP8Flu8XxG08DxyID4UUr5AMi9bhRLAI2wpnnpu0VYQwuqxm
 ozzkDLIpUMoGSJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEG1qwIZ2MQhDb0Rn5TCwHWbo
 CpfPZNiBFnD7oJ3lzlHo4gNjO1bc1KgMriPCuWoweweYUOp7A73HI6oJg7w/Vod3QTO7QTL/vMcL
 queBWI153jp7haOSLlxw44w9I2ZifS32EoSnB0KQ6B3xt8UP9IqiIoZ5y2slXm/bJtJoELtOerz9
 cqOXWO4+PQeXdSLIvWbNx97ETyrT/kUypunSsdmZTxBtf62a3sV/wO5yplS0ctgzcDoFd+96Xw4Q
 UNtTnaqKMELGl6tE0K+BcrxAjOpojt+2wgmoPg0r3fLmjzUcOV+CuA5GimAT6h9Ujgm5ShD2vvTW
 dasCwvCiFabvBgs1Q2yTITNEqokCKaRTOpRi1i3DxpeppJLPqpIzQH91oWpnoGrsoLVX4uRIcZji
 Lua7QDsLZwFcOTN1VL7o22jDHzxYOOo85NMG/uIDWvq5VedjXZBNOJeqVzGgrKtR6HA=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-20 11:49, Steve Dickson wrote:
>
>> +__attribute__((destructor))
>> +static int nss_plugin_term(void)
>> +{
>> +	free_local_realms();
>> +	conf_cleanup();
>> +	return 0;
>> +}
>> +
> Just wondering... How is nss_plugin_term() called/used?

Automatically during dlclose(), see the 'Initialization and finalization 
functions' section of the man page. I'd originally thought to extend 
trans_func but didn't see an easy way to extend the api (no size or 
version field) without breaking any possible out of tree plugins (do 
they exist?).

Doug

