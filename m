Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE2188311
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2020 13:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCQMJZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Mar 2020 08:09:25 -0400
Received: from sonic308-2.consmr.mail.ne1.yahoo.com ([66.163.187.121]:40972
        "EHLO sonic308-2.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbgCQMJY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Mar 2020 08:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584446963; bh=kcevCRoll2+Bsa3FDERpIV72LVcB1A4YV1b5N2AWYBk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=LKXOn4M0j5u4cAGJEZR3toF99ATt65AAiQHRzms7P5pK/dyyDOOemxRA/Td8nnTXIMJ0Dse9IdpOxwzhXHMp8WfA89ZmdV+f0yVxoovPh89GHsuRf9RQFmQiFyPQP5TkzbG6z45Ve6D+EfMulbIFkXkJhu9aj6oPSTYtDaHoZNP2hTNXsYceT6asMnOaSsujAVLbavn9AapWzLrR8/UnMyFA7MHgHtrpiyrkl0HidDiiMULKFZx3V76N/cw3N1J9gF49XKq68i0m9V6CbdmbggGDASkdMlrl610PYlrwcc+8zgJKHfDSovRHC2YCjNYY+5dLmammeCSsby9cScQmng==
X-YMail-OSG: j32Ad0wVM1njmsdmxGTWnxZPSwUgi2gt4h6B_66IO_poOsdaw5QyOe0B.DC4iYT
 SBZuw76ouWZfxotzBkaOiolzygojjZyxfO9tlLvC97.l7egvz88hSdoWwcVubU40dbb6p2K2QxNb
 RqpiHcIlHfLubICX0Wx3Gc4020VCQL0ECBwfUCQNapgpzj1Wjkq4NWKlujBdevzipQYywoDnrUk9
 SLvJKaakYCUvOEBpzc9wITe03ElvML3uF_0upUzEZIWr1dVo.GEFb1BeXcq1r5WIsESPis_HQnIS
 c65QeJteoUih8_bDdVP05JAVv9Dyc2hc0QhQthz.CmPGag0pfknbfwmiQD59l9gRO3wvBlX4UKsB
 bRZI2oEXIJ9WrXTOCfdkWa703kw.1BW1Q3oV465vmuTKVeNr4HgcCi7tr3HuNlm2qsDIFeVeJlJi
 cUe.t6F31BDpLW9tO.ISNlTE9g9q16tSDzZJZaMZ0H3JTqNQ15_Ze5FCjnS9SwLvFnOJW5_lFUe2
 .NiTBFls4mN1PZ1wzAOqb4vFsoSloN26K2yFM2ohiYc8h2YNtKrRpahA_chckQADTR47RiTlrYZN
 sCFWV6YGULBJqCwg2IOrB4nCdZp0NhKNtqkSLvvEmS1bljOHmlJbpAU5317Wo7..lZNLPPj4bl8q
 PCFvPYi1C58OjGBswVJQRz3nZ_7R4bwGOK5WbjFuEKDp_VKPmbQXhgMGTew7BHH8Ksi6UBaWKxAP
 SzxdIqIGfLdU92cauX5wtbrbFuGUmx36_9fXla5tqoB2bWQhetD5Kk8hD2SMYdLweeh3xZajMWQ_
 t1HcaaFXTpIx5q5oWb4RMtt_9eykgItvdOSaneASdFiF6ZCmlII_mZwrCsZuse1bAZMnmWjQuEoD
 fTFp91f8EX15bMRmlj39wJvkNKHlLp02dw.arrQlUfKeYgfGt5NPW2SDZKFskV__bX58ErZsRY.2
 2jYm9d.k81jx0WlUQ5AgEqEm7UfoVj93Wz1VIMHlFd4__zdNYGMXn.xlrz31B08jw39QLUeTdQ7r
 WSydyoMeWlkRyuZi.FzSKn7EUY5mHWRyTFgLEoNk_R9YFIMDawrDOHoFNpm.dLuodg4jZOmKrXwl
 IFUmMWmWOD1QwQdWxRZ54u5V_iugkD0yw03ayEvtKbrv3l.QoRmsRlT_DoTqp43olJXb4Uby0okZ
 6pWA8BAMSs6yLqJkoad2nox6Vt4a7CdfT.vQchyP683op51t4CwEQtRYUxX6nfbdelCDKL._eB5v
 9GpzHgOIcw6o77Nw83FsmU7FBsu6BVqkGUxamoZ5tk0MoEd9V9U.G5eCpoyJS4yEfe6nMXHTjheM
 1tR5_cwCVlOLkvNZC06OtMmOqYXtZDus2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Mar 2020 12:09:23 +0000
Date:   Tue, 17 Mar 2020 12:07:22 +0000 (UTC)
From:   Stephen Li <stenn7@gabg.net>
Reply-To: stephli947701@gmail.com
Message-ID: <1992313604.1815720.1584446842907@mail.yahoo.com>
Subject: REF
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1992313604.1815720.1584446842907.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Greetings,
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is
interested in having a serious business investment in your country. If
you have a valid business, investment or project he can invest
back to me for more details. Your swift response is highly needed.
Sincerely
Stephen Li
Please response back to me with is my private email below for more details
stephli947701@gmail.com
