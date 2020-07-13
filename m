Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7091621E2FA
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2020 00:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGMWXd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jul 2020 18:23:33 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:49555 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgGMWXT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Jul 2020 18:23:19 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jv6qQ-0005u7-SW; Mon, 13 Jul 2020 17:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kmIdc3T+2q+EIZycDW7UScrhgP1rwQAr93ykfFPVMLc=; b=YuaqRF4j66imEl+oP6fgEmV5y+
        RQlRistss0gEdKQ6KaJ1sWJIIeDiPqMKRPpR1CuYHuD7D9UUimZhB+WmqYE1UvBbeLClUZsVZ6Ng1
        dD2hNNot3AGMmgZVmYbnN01aCCfRoFYSy1fMioF1ehrp4wjn4aA0IJhgzhzpIVoR7Gag+BNx8Cp5Z
        ClkSlY6s0z9iZ1+ZjnL3dy5S6fX5/WKQTF7KWZUEa1pzrRwf3h3vbD7bk3XlV2NTCP8ZwLfg3BAzA
        dN4xopPJEUCXmlW7rix5a0MKtaS+QMuFDlPGPuWnpu0UOQDxUOo1a6PL60lYgKapbv3nttGpc2r5j
        PdbiW3uw==;
Received: from [174.119.114.224] (port=60136 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jv6qQ-0008Js-K1; Mon, 13 Jul 2020 18:22:42 -0400
Subject: Re: [PATCH 04/10] gssd: gssd_k5_err_msg() returns a ". Use free() to
 release.
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200701182803.14947-1-nazard@nazar.ca>
 <20200701182803.14947-5-nazard@nazar.ca>
 <3a758b78-e477-4a75-63ca-65333a413599@RedHat.com>
 <cddca53b-54f3-2c4a-f6b4-b0bb2bf2b2f2@nazar.ca>
 <ca47067c-3b8f-b33a-a274-87039d5d6cc9@RedHat.com>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <a75ee893-7766-f47e-a342-07e733f4db89@nazar.ca>
Date:   Mon, 13 Jul 2020 18:22:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <ca47067c-3b8f-b33a-a274-87039d5d6cc9@RedHat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.17)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVe4O5Rs6OT3f/
 60wjdAUakETNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTibW
 aG5S00Ke4iKnmCsTdmJlcUeN/JW8E9PaHbmUYGTMTX+DNB8zzxX/4FjqtJmb5N8G/+QQ3aF4zmLI
 tgOrx7cBzS5fPHINUJxVzZg1ZLp9WsNs/TiGk4ran4P5akI9/iSD+AOQ3aTXsOlBj1rS7KuJKV22
 DmcCOObp+EfB9TVxwAQsq9Jr0hwdTzDySvwsAZ57yox544FFkGIGo/UPEJklPZ+d+6dQltnW35dY
 HDi4YsOSYzzrWOkGpzUJhy0xLBRKoVbdmzfZG7WP8P7/emcDFPZI3xOxBaPpD+a4iBFJkhqbiTdT
 lYcOHnVgVGtCG6MIpAaBCnEm0QC5cIoZWwuuqr0aikOvJA+DuzeF4b+ym3AhG426mliYkCHBZpOg
 oqc4uCQ1hIibn+MrIDYy2WDv159KWP8Flu8XxG08DxyID4UUr5AMi9bhRLAI2wpnnpu0VYQwuqxm
 ozzkDLIpUMoGSJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEG1qwIZ2MQhDb0Rn5TCwHWbo
 CpfPZNiBFnD7oJ3lzlHo/bVF9ZxFOapkrnh1bYXbWAeYUOp7A73HI6oJg7w/Vod3QTO7QTL/vMcL
 queBWI153jp7haOSLlxw44w9I2ZifS32EoSnB0KQ6B3xt8UP9IqiIoZ5y2slXm/bJtJoELtOerz9
 cqOXWO4+PQeXdSLIvdLkopSyM30WB3ISKlXCPw+4YTMeswZjU567O3SXiFI4ctgzcDoFd+96Xw4Q
 UNtTnaqKMELGl6tE0K+BcrxAjOpojt+2wgmoPg0r3fLmjzUcOV+CuA5GimAT6h9Ujgm5ShD2vvTW
 dasCwvCiFabvBgs1Q2yTITNEqokCKaRTOpRi1i3DxpeppJLPqpIzQH91oWpnoGrsoLVX4uRIcZji
 Lua7QDsLZwFcOTN1VL7o22jDHzxYOOo85NMG/uIDWvq5VedjXZBNOJeqVzGgrKtR6HA=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-13 14:47, Steve Dickson wrote:
> or even that the library was compiled with the same malloc library.
> There are different malloc libraries other than glibc?

Not including the various libc implementations (dietlibc, klibc, uclibc) 
there are several specialized malloc libraries (dmalloc & jemalloc are 
the most common) that you can compile or link against. Usually since 
they replace malloc and friends everything works, but you can get into 
issues depending on order of linking and how you compile.

I recently put gssd though a few rounds of mallocfail, which allows you 
to progressive test every allocation point (during normal running) to 
ensure it's handled (instead of crashing). I've an updated patchset that 
fixes the event2 conversion to check for successful allocation and a 
couple other spots that crashed if the allocation failed.

I'm taking it a bit slower this time... kinda rushed the last patchset 
out the door since I was needed on another project.  ;-)

Doug

