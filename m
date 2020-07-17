Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D034224636
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jul 2020 00:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGQWPo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 18:15:44 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:36365 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727840AbgGQWPn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jul 2020 18:15:43 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jwYdo-00060t-9b; Fri, 17 Jul 2020 17:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=o3jKHEUoYzYEfNYmIvsUhfX2Il/Df+AxFVxi9w9ZRN4=; b=Gruf4OM7FbNXDFUZ+rQNDKbKi1
        baYfPqAHxxnriSEw7OSNjCd3cd/IUSt47orW/3jZiyyaV/QrG8SxPjGFxUWBnxxBMzMxPmLMDIZK9
        ADpqbuR7f7OJ+y2qtC0Bv9icizba1mj2R0duYvaWeAB4v4PFGHvz+Rvoa47jUhBXoHoaQxOlBN/0Z
        uI7Gc6s1NlMuj/+BDMh6w/9BnK/RvK7Hqko9Dxh+jJJ8eN6cRdPVKsN+rd18l5/frv46dPt/YPApY
        4rf+Z5KM75wRTk4VibDXQ0RmuQkK5iIFLzK63LA0Fdw0FeT41i2stdP1plsvtGMVSoJk97/X+/9O8
        B8NJwh1Q==;
Received: from [174.119.114.224] (port=56789 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jwYdn-0005mN-Ku; Fri, 17 Jul 2020 18:15:39 -0400
Subject: Re: nfs-utils README updates
To:     Steve Dickson <SteveD@RedHat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
References: <34f07da7-250d-f354-bf59-74b9f1a0e16f@nazar.ca>
 <0555b3d1-8cbe-c3d8-2214-2bf7d3d65286@RedHat.com>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <8ef6b702-0cca-e5c7-d873-afc21effe4df@nazar.ca>
Date:   Fri, 17 Jul 2020 18:15:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <0555b3d1-8cbe-c3d8-2214-2bf7d3d65286@RedHat.com>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ZZlDYW4q2llG44Qh0NJtYKpSDasLI4SayDByyq9LIhVdCVOjSkkhSEM
 7YpCVSPnAUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K0u7bp06KWZE5kJo1RQt2r0uc
 7AzjRBXOY6yVfGpMIXfS8FYbT30fGHQ1v2jpPnlJuACHRlSIHh1ESwkQpflXKDGNDVE1ZYSY6caG
 A3myES+HEm5O5zjUyxKPrjaFMmXa4pWx7WxWFZpsjT/483ewgvHlrPSaS+xZNYm40u9o/aK1MGQL
 MCZt5tUlQdGweh2/0YyzW49ThK0/vjxlhJxWXWv9sTmiX3s7x6951RQYvzC1+Pl3NUY3kPXG87u7
 QBZfxDkI+SWq7yHaGnRW4Sv/WZ246ZdR16xGrl0BlC4VTcf/kiulmA5dedVDtY5Oo9F/pm/QGGPs
 U3D4Y5KtFugk6Z4diAeozmivfpf7h7tUoJgxCovAuWs7sG3ASSCelbRWB8ZKUXpPqsZtoa2biP1C
 Vuy5KYo4nKkmpa1tqyW+hz7BVFWSrNHngturlRbNKAJI4GHNHaRHRoY9AiO4OVzwbM0HPoL4y76E
 anCvs8GqYqdtrOYSNX9uXFzaooMSV8AuAJr9BiUkdefQcdW2OEoQ/bix99BfWjSAFfOTRj3Uo9bo
 nV+E7OMXRvgtdyMlnmWiny6OvzbxEoF0vCz5uoyntDwmGxhsUKuT6gxgwFiMhATdDkV9+VOUixjQ
 rHNVxRe6aTAKgVsAZTodOXSJUi93tb2ZxJTUPyQvJxPlOf6GYlT/EyUYfSCsEnJ6AIyUfOWdW/EN
 6OpzWBK8DZjEJE5wwmjmUhnjY+kgx3rv6P0wL+JqiAE5pwKylKODoBbEqRaPDstjIQ2/91BJ0Vl1
 mCs1wfCLxx/4FIHNUcvGiJXwqIqekGQ71QHCUYKg7oNhkiQXa68u4HG1DXXIJUAW3le3YPUf9oDB
 qtClgM5jH/om1Q59d9QKKwI1dgVnpUV+OnV8j7FdFHb+Xtqat65R8ZI8Vc+EpWNITRoH6M6FGiVg
 jKXBGr87fj2CFhZ4MGbsqowmXmHRaj3V403wS9rCCUpVHPXT/oy/kRT9hGJ428r1MWzhjMzrarBl
 S86MXqQQTzt3
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020-07-17 13:34, Steve Dickson wrote:

> Yes... the README is dreadfully out of date... although most of it has
> not changed but a lot has... esp when it comes to the systemd set up..
> although the systemd/README is pretty accurate... Maybe a point to
> the systemd/README in the top README would be good.

Sure, although I don't use systemd myself, I'll have to trust it's correct.

> What script did you have to add 'auth_rpcgss' to?
> It should be automatically  be loaded when the sunrpc
> module is loaded.

/etc/init.d/rpc.svcgssd (on Gentoo).

Looking into it, looks like sunrpc is included & loaded from the 
initramfs that Gentoo's 'genkernel' creates (for root nfs setups) but 
not the auth_rpcgss or rpcsec_gss_krb5 modules. Which makes some sense, 
since i can't think of an easy way to do a krb5 root fs with a generic 
initramfs. Kind of a chicken-egg issue with getting kerberos initialized.

I suppose the other option is to allow svcgssd to startup and wait for 
that file to appear. I already have patches that convert it to use 
libevent so that shouldn't be too much work to add.

Doug

