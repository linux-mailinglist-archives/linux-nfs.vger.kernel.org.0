Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801DF2112F8
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2020 20:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGASqF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jul 2020 14:46:05 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:55817 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgGASqC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jul 2020 14:46:02 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhk6-000876-L2; Wed, 01 Jul 2020 13:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BREU0FpvUdrU3RXfiYSTjvzs4IxVY0emTpL2ex2TLDM=; b=jcDrqMgOvN8zmUsXLFG61P3D/T
        oAxitQRtY9fAI7Ivk0UjzgNA/EhPHxM5M0LgxwJIDJNwkeXVSjHDM1pCYSI1NPlpiu2PTU+o4HCyG
        zkWPbv7oXCO4insoM7l5p7vy6EXGK5ox6p9KQKdkuKcOWV2/GjuFs7F8o4gYWxGVX6HeFZ9BK4V3E
        ITjnT1sO7csnVILhP3ox4S0C0Hy9wUKIL3yTIbvD2ZcUZ+QfYGy2WkONrATIAgldg7rF/mqymFyW+
        xN3Pcm4zuFLl3doEL8XJt5nZ10ykSc5QIbTNNIE4Di/J1OdfNsoEaZ2zy5j6+uWnkC6/fZjGFNxyn
        7dx1gdag==;
Received: from [174.119.114.224] (port=61040 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jqhk5-0005Xm-9J; Wed, 01 Jul 2020 14:45:57 -0400
Subject: Re: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in
 Debian Buster
To:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
 <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
 <20200626194622.GB11850@fieldses.org>
 <3eb80b1f-e4d3-e87c-aacd-34dc28637948@nazar.ca>
 <20200626210243.GD11850@fieldses.org>
 <bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
 <6cf63c80f285495d8328c5c8b55fc9d6@tu-berlin.de>
 <41614030-a616-1ad0-280c-7e24342cd455@nazar.ca>
 <94422f073b7e4b979931e6d8d3a0c044@tu-berlin.de>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <55d6fafa-222c-1d55-d1ec-0bb6d7ab9350@nazar.ca>
Date:   Wed, 1 Jul 2020 14:45:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <94422f073b7e4b979931e6d8d3a0c044@tu-berlin.de>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVWhTb2ukwNjpu
 pOqJNggCMUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K5r8HtW+i+zOSEp4G6/nKThTT
 uTzzE6IXwvY6nHo4sMR7z3Qmxf9LL3YwTn7mqFDKhD3eopicjALgkOhTtfsl+Ko2AgdDl0X122/y
 ecgK81jzTv5D+BQ3Vi95Abf6JioEQjBWL8RNTyPJzsds9V/6lEwmr6TNDmoNGsncSY9bd15pRS7f
 7mZVK7fXToVZ6vCgu4aV6E2UnWQ5LtEEB+XvLRyeP3kMF/HM2qi7bXBmBn+u1WaiZswnh7amfkLT
 IEwd6LkGFt94dBx3TpAokA4UmbCGVypsM2xk+Fb6Uy9BG+eG09xLM7yGwGwdmctNXf+yF45HU3lW
 dqhlsf8B0aV+vLwhC45y7F6Q5PEoXTb+KPAIoaacdoUTZPqsW5IYvohDIxfs2qKc0fhF4YMd0lwH
 wOXyY7DGIntSiB4r6Kj1fsgmrNzcio0vvTNoY5tUR/a/1p3btshdqNdejy9cf5FpO1goS3MkISSy
 dS6EA7KSoHbm+ifPs2yIXVaS7j1CpD4sbMC/K6klzbRMjzrXH/SDfWiH1Wgh6RAenBR+licROGZg
 nHuN3T3lnVlGD4niHpIoevbTmP6zX4CU1xL6keyrGQoR9z8TmFlnY3VX7yj8G9tHfqKKhnXuHBKx
 2WmGgCd6OGA/nCOmvrY4iQcbIGanrffQsJMjVuaCfq+S2F3DJOIRFZ4oobg8BBg3Jq+ntzj0rh/2
 2eyHcgpFD92kILePdl2bSnc9GinQymBttOmXG2+YYq6GoR6LNawMwPEsp2qDrtVoASEhWt9d1pcs
 OxTmycA/9xGgj7taJxWtHZ97uYqgmGT5RbB5IWt8fZ6ctVYFYnNGFdRN3CtPPBjSHkIxZatgw7Jg
 KTqMJNGdaglvWusdDN2jqhFWg+7z30fj3VpdeToUvy4JCT53crzj1o5/muiPCtB/5ydmLUuJyvfZ
 LuDOE4wUcLzs7u9jpBeoYE7DC0Hh3V60YI4Fdc71eibaCdbFBCUcNiB34tnDdEu8PUIxL7hrJSk6
 0SF3F6RYOYr2
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-01 03:39, Kraus, Sebastian wrote:
> OK, thanks for the info. I wondered, because your patch did not show 
> up as a commit within upstream.
> Your patch seems to do a good job - no more segfaults since a period of four days. :-)

I'm not a maintainer, just an enthusiastic user with a compiler... ;-)
I'm sure it'll get applied in the near future, as time permits.

>> I've found one other place that has insufficient locking but the race to hit it is fairly small. It's in the Kerberos machine principal cache when it refreshes the machine credentials.
> These type of patches are always welcome. :-)
> In the recent past, some of our scientific staff exprienced strange problems with Kerberos authentication against our NFSv4 file servers.
> Maybe, the outages were in connection with this type of race condition. But, I do not know for sure as the authentication errors did happen on a rather sporadic basis.

The previous bug could also cause authentication issues without crashing 
depending on load, timing, memory usage, malloc library, etc. This one 
would only crop up during machine credentials refresh, which by default 
is once every 24 hours. I've just posted a patch 'gssd: Fix locking for 
machine principal list', the interesting part for backporting is around 
line 447. It used to always strdup() even if cache name was the same.

>> I have a patch for that, but it's pretty invasive due to some other changes I'm currently working on. Let me know if you hit it, and I can work on a simple version to backport.
> NFSv4+Kerberos is not for the faint-hearted. I do not fear of invasive patches - as long as they are not missing technical correctness. ;-)

No guarantees... but I do try.  ;-)

> A question far apart from this:
> How is it about the spread of NFSv4+Kerberos setups within academic community and commerical environments?
> Are there, up to your knowledge, any bigger on-premise or cloud setups out there?
> And are there any companies running dedicated NFSv4+Kerberos setups?

I really have no idea. I only run it on my home network of a few dozen 
(old) machines. From what I've seen while googling
trying to figure out how the code base works, there are fair number of 
users. There's also been a large amount of work in
recent years, which would point to something driving that.

Doug

