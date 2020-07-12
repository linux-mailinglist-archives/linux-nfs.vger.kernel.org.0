Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736EC21CB4E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2020 22:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgGLU1f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Jul 2020 16:27:35 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:43883 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729012AbgGLU1e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Jul 2020 16:27:34 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1juiZP-0009VS-NH; Sun, 12 Jul 2020 15:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bjCy7qzhk1Z2uFyHsRN8A+ZSI1v3Z1oaBuMxfYGnrBE=; b=XtOyUs8RqgoWrV87gt5KC+UUOM
        xr//eWZqWopt8fSQvWKBpWPQxf4dxHhYlvlhAJNjp3Htn6CIzKcyFOKQ8UPKKHyFng/mWm/4+3s6y
        b8JdOQYkILmXe//Kwf6qymFFHGw5dj718nbTdefmWb0xn58yQ85J5Q/8DsaOl+61F4rNrXp3IolFR
        4kmUW0mq55ryJBt2jUulVX/aZ5aXcfHDnYt+AJiSbeISQ/z51jFphPW4HeLVQKCzukuJjkf1uNGAX
        Gj1hFOQy7seNsu8leVx3M6znEAlospNgXVvKqCgOClD2GBYLxMM2pmIyQcQ6M9DFUFk2JI+77kaHE
        G0K2b8uw==;
Received: from [174.119.114.224] (port=57117 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1juiZP-0004pj-DA; Sun, 12 Jul 2020 16:27:31 -0400
Subject: Re: [PATCH 04/10] gssd: gssd_k5_err_msg() returns a ". Use free() to
 release.
To:     Steve Dickson <SteveD@RedHat.com>, linux-nfs@vger.kernel.org
References: <20200701182803.14947-1-nazard@nazar.ca>
 <20200701182803.14947-5-nazard@nazar.ca>
 <3a758b78-e477-4a75-63ca-65333a413599@RedHat.com>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <cddca53b-54f3-2c4a-f6b4-b0bb2bf2b2f2@nazar.ca>
Date:   Sun, 12 Jul 2020 16:27:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <3a758b78-e477-4a75-63ca-65333a413599@RedHat.com>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.28)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhV2WclDDswA3em
 GgSZl4yiS0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKTibW
 aG5S00Ke4iKnmCsTdmJlcUeN/JW8E9PaHbmUYGTMTX+DNB8zzxX/4FjqtJmb5A8w80uXx5o28guH
 9K17bBIBzS5fPHINUJxVzZg1ZLp9WsNs/TiGk4ran4P5akI9/iSD+AOQ3aTXsOlBj1rS7KuJKV22
 DmcCOObp+EfB9TVxwAQsq9Jr0hwdTzDySvwsAZ57yox544FFkGIGo/UPEJklPZ+d+6dQltnW35dY
 HDi4YsOSYzzrWOkGpzUJhy0xLBRKoVbdmzfZG7WP8P7/emcDFPZI3xOxBaPpD+a4iBFJkhqbiTdT
 lYcOHnVgVGtCG6MIpAaBCnEm0QC5cIoZWwuuqr0aikOvJA+DuzeF4b+ym3AhG426mliYkCHBZpOg
 oqc4uCQ1hIibn+MrIDYy2WDv159KWP8Flu8XxG08DxyID4UUr5AMi9bhRLAI2wpnnpu0VYQwuqxm
 ozzkDLIpUMoGSJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEG1qwIZ2MQhDb0Rn5TCwHWbo
 CpfPZNiBFnD7oJ3lzlHojRGzBQHOQ3SsIuUJhCuF+QeYUOp7A73HI6oJg7w/Vod3QTO7QTL/vMcL
 queBWI153jp7haOSLlxw44w9I2ZifS32EoSnB0KQ6B3xt8UP9IqiIoZ5y2slXm/bJtJoELtOerz9
 cqOXWO4+PQeXdSLIvWYSkUSisXvtzkgU38+CGrV/1KWa+8pQmclXa6spg6jwctgzcDoFd+96Xw4Q
 UNtTnaqKMELGl6tE0K+BcrxAjOpojt+2wgmoPg0r3fLmjzUcOV+CuA5GimAT6h9Ujgm5ShD2vvTW
 dasCwvCiFabvBgs1Q2yTITNEqokCKaRTOpRi1i3DxpeppJLPqpIzQH91oWpnoGrsoLVX4uRIcZji
 Lua7QDsLZwFcOTN1VL7o22jDHzxYOOo85NMG/uIDWvq5VedjXZBNOJeqVzGgrKtR6HA=
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-08 10:50, Steve Dickson wrote:
> I'm curious about these changes... since all krb5_free_string()
> does is call free()... where is the "strdup'd msg" coming from?

gssd_k5_err_msg() always returns a local strdup() of the error message. 
We shouldn't be using a Kerberos library method to free them. There's no 
guarantee that the library won't change, or even that the library was 
compiled with the same malloc library.

Doug

