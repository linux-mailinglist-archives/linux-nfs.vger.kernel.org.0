Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42A422B5B7
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jul 2020 20:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGWSci (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jul 2020 14:32:38 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:60943 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbgGWSch (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jul 2020 14:32:37 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jyg1C-0006Xo-B6; Thu, 23 Jul 2020 13:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nz75GbzzNtrx74Sr8p+M/8mpT5zSKLO4mzRAs341uJY=; b=KIWO0EJTxP5+GLvp+KYK+i3fw4
        EZpDPV1ZhEmp6q2iWBsDnm//qkD9ux2VBt/k1dF3YU+FLZp4YMwFI/lajZ32simlLDtGynCCoMHa+
        xMeBmpqQl/oEzo/y1pyvlcm6NpVSTxqU3KUGmkztIIMIqkMkXSYExU408SUZeJDBOYNHHE7byejvA
        HaklH7FpJxystOdaUhjvt4om5/jqt1wSG6WvktJddrmXZnDK/5mFD9Na71RupJsg5FWWVrvza9dXp
        TsA7of/By4/TuLhX3zRgi2eeXwOPZVs7QNRO7q/wBtR4P+LbJ0LupBS2TdEc7NN+3LWKzgPJBlQw3
        eB9uYMGA==;
Received: from [174.119.114.224] (port=51492 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jyfuS-0002m0-U8; Thu, 23 Jul 2020 14:25:37 -0400
Subject: Re: [PATCH 2/4] idmapd: Add graceful exit and resource cleanup
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200722055354.28132-1-nazard@nazar.ca>
 <20200722055354.28132-3-nazard@nazar.ca>
 <c136e451-f10a-c3a2-7f50-12735463275f@RedHat.com>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <5170afa5-9751-0ab6-5e93-f103857ee259@nazar.ca>
Date:   Thu, 23 Jul 2020 14:25:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:79.0) Gecko/20100101
 Firefox/79.0 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <c136e451-f10a-c3a2-7f50-12735463275f@RedHat.com>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.21)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0bN4ZX/cCaR95pQ7tQtUF1ypSDasLI4SayDByyq9LIhVc2NAGV9zgEqo
 dyy7kthXL0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTibW
 aG5S00Ke4iKnmCsTdmJlcUeN/JW8E9PaHbmUYGTMTX+DNB8zzxX/4FjqtJmb5LDZU8Ees/fl/p+a
 CK2z7fcBzS5fPHINUJxVzZg1ZLp9WsNs/TiGk4ran4P5akI9/iSD+AOQ3aTXsOlBj1rS7KuJKV22
 DmcCOObp+EfB9TVxwAQsq9Jr0hwdTzDySvwsAZ57yox544FFkGIGo/UPEJklPZ+d+6dQltnW35dY
 HDi4YsOSYzzrWOkGpzUJhy0xLBRKoVbdmzfZG7WP8P7/emcDFPZI3xOxBaPpD+a4iBFJkhqbiTdT
 lYcOHnVgVGtCG6MIpAaBCnEm0QC5cIoZWwuuqr0aikOvJA+DuzeF4b+ym3AhG426mliYkCHBZpOg
 oqc4uCQ1hIibn+MrIDYy2WDv159KWP8Flu8XxG08DxyID4UUr5AMi9bhRLAI2wpnnpu0VYQwuqxm
 ozzkDLIpUMoGSJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEG1qwIZ2MQhDb0Rn5TCwHWbo
 CpfPZNiBFnD7oJ3lzlHoHnnxAT5HW1DTreNoOWYjDgeYUOp7A73HI6oJg7w/Vod3QTO7QTL/vMcL
 queBWI153jp7haOSLlxw44w9I2ZifS32EoSnB0KQ6B3xt8UP9IqiIoZ5y2slXm/bJtJoELtOerz9
 cqOXWO4+PQeXdSLIvTGDem/okwedWQ/rPWChp1+1bJlhenYCmzeGs3RQe40pctgzcDoFd+96Xw4Q
 UNtTnaqKMELGl6tE0K+BcrxAjOpojt+2wgmoPg0r3fLmjzUcOV+CuA5GimAT6h9Ujgm5ShD2vvTW
 dasCwvCiFabvBgs1Q2yTITNEqokCKaRTOpRi1i3DxpeppJLPqpIzQH91oWpnoGrsoLVX4uRIcZji
 Lua7QDsLZwFcOTN1VL7o22jDHzxYOOo85NMG/uIDWvq5VedjXZBNOJeqVzGgrKtR6HA=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-23 13:56, Steve Dickson wrote:
> @@ -290,6 +306,9 @@ main(int argc, char **argv)
>>   			serverstart = 0;
>>   	}
>>   
>> +	/* Not needed anymore */
>> +	conf_cleanup();
>> +
> I'm a bit confused by this comment... If it is not needed why as the call added?

Sorry, I should have been a bit more verbose in the comment. I meant 
that we didn't need access to the config file anymore (we've already 
looked up everything) and can free those resources early.

Perhaps /* Config not needed anymore */ or something.

Doug

