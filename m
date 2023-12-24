Return-Path: <linux-nfs+bounces-797-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDCC81DC57
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 21:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8078B1F21592
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Dec 2023 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF40DF46;
	Sun, 24 Dec 2023 20:31:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dsmtpq1-prd-nl1-vfz.edge.unified.services (dsmtpq1-prd-nl1-vfz.edge.unified.services [84.116.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A479DF52
	for <linux-nfs@vger.kernel.org>; Sun, 24 Dec 2023 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grumpydevil.homelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=grumpydevil.homelinux.org
Received: from csmtpq3-prd-nl1-vfz.edge.unified.services ([84.116.50.18])
	by dsmtpq1-prd-nl1-vfz.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <rudy@grumpydevil.homelinux.org>)
	id 1rHV2v-00Flz6-Ke
	for linux-nfs@vger.kernel.org; Sun, 24 Dec 2023 21:26:01 +0100
Received: from csmtp3-prd-nl1-vfz.nl1.unified.services ([100.107.80.136] helo=csmtp3-prd-nl1-vfz.edge.unified.services)
	by csmtpq3-prd-nl1-vfz.edge.unified.services with esmtp (Exim 4.93)
	(envelope-from <rudy@grumpydevil.homelinux.org>)
	id 1rHV2n-00DLZ3-4g
	for linux-nfs@vger.kernel.org; Sun, 24 Dec 2023 21:25:53 +0100
Received: from imail.office.romunt.nl ([94.211.190.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp3-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id HV2mrGVBagCHMHV2mrSn8G; Sun, 24 Dec 2023 21:25:53 +0100
X-Env-Mailfrom: rudy@grumpydevil.homelinux.org
X-Env-Rcptto: linux-nfs@vger.kernel.org
X-SourceIP: 94.211.190.96
X-CNFS-Analysis: v=2.4 cv=YZG75RRf c=1 sm=1 tr=0 ts=658893d1 cx=a_exe
 a=yUtl1reNjyGjWLz0WBI8zg==:117 a=yUtl1reNjyGjWLz0WBI8zg==:17
 a=gM4HPJ0XbovVCY8R:21 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=CjxXgO3LAAAA:8
 a=2z1OXlWFAAAA:8 a=o4LVTJpuAAAA:8 a=taplWCyty4B04Y7pyq8A:9 a=QEXdDO2ut3YA:10
 a=SNRPda0NjyR9MlWdJ_lJ:22 a=JasTbRFHc69gwGtKOLaw:22
X-Authenticated-Sender: romunt@home.nl
Received: from [192.168.30.70] (meriadoc.office.romunt.nl [192.168.30.70])
	by imail.office.romunt.nl (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 3BOKPhSN009203;
	Sun, 24 Dec 2023 21:25:44 +0100
Message-ID: <e274b55d-9818-0919-fb90-bc6d0b522b0e@grumpydevil.homelinux.org>
Date: Sun, 24 Dec 2023 21:25:38 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: I can't get contributors for my C project. Can you help?
Content-Language: en-US
To: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>,
        "polarian@polarian.dev" <polarian@polarian.dev>,
        "misc@openbsd.org" <misc@openbsd.org>,
        "tech@openbsd.org"
 <tech@openbsd.org>, Jan Stary <hans@stare.cz>
Cc: Richard Stallman <rms@gnu.org>, Bruce Perens <bruce@perens.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "ansgar@debian.org" <ansgar@debian.org>,
        "blukashev@sempervictus.com" <blukashev@sempervictus.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Dave Wysochanski
 <dwysocha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "editor@lwn.net" <editor@lwn.net>, "esr@thyrsus.com" <esr@thyrsus.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "moglen@columbia.edu" <moglen@columbia.edu>,
        "skraw.ml@ithnet.com" <skraw.ml@ithnet.com>,
        "tcallawa@redhat.com" <tcallawa@redhat.com>,
        "torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>,
        "torvalds@osdl.org" <torvalds@osdl.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Julia Lawall <julia.lawall@inria.fr>, Paolo Abeni <pabeni@redhat.com>,
        "jon@elytron.openbsd.amsterdam" <jon@elytron.openbsd.amsterdam>,
        "netbsd-current-users@netbsd.org" <netbsd-current-users@netbsd.org>,
        "netbsd-users@netbsd.org" <netbsd-users@netbsd.org>
References: <549578214.4148875.1703446908152.ref@mail.yahoo.com>
 <549578214.4148875.1703446908152@mail.yahoo.com>
From: Rudy Zijlstra <rudy@grumpydevil.homelinux.org>
In-Reply-To: <549578214.4148875.1703446908152@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.9 at imail
X-Virus-Status: Clean
X-CMAE-Envelope: MS4xfDZ11GDdT1ZYNYfc24fec0VWXZ4aS7RQRmXy0urxviGak0lM4mlt42j/9G5HRAtlhOvHn8rpKfVTva9NoJurvyo2Bjhfp2bH2P4naKL4zeXqIstHHt39
 WZTDRWPyK03A4aEKVFa/LbTqPzmT1FJ+wQK59QBJnd+FuQLHzvinsHjQav52WzDoSuJ1B0B4hzYswcPxrodILIH3WWmA3KFKvM/JAMyvtI9dI34YXDfLqp2v
 xwVsq/6m0uXdVCrjXKyXCle9s/O5tpNECUsq3odr2OI8KM98N8FHnBnAfGbp8PdReMr//X6rNsoeQgBtpiPTXyMYdL42kRNleaH5LHb8+EWV89fPdiTzEJye
 Kv3TKGQz0bcUZ/ne3gNXyV91UOaW1B81+sNILBZ6xSgWLu5Qyv0Jg3nKIQEEqBXn+2Da3m+df5PajMfgZREjRgJmk8+84IW7xNTV9LxdsIf6jerAeRQQUNNy
 GOyzCe0hjV+2UiLf5yP2HLz2NbZvmaF4EEgPOpLekL1uyrYxbqdwgiMSAUMTrq5AlHYfvU1gd5G62wn+xiZ/E8UF018LTMsxCa4px4mlLYuMJ07DpL/YTvVv
 qXO07/w49p6bUntgBCj1lVDAx8/+vxJ6s62NVZI7G419A7eNzgaxYmSnyGuGJMAWVz8WBaQUL/bHBPCqPtDf1vot8GMh4ZcscNKboEZGyxkG5IWUpFTjNe6U
 gPq2hJOGfQJxHSy8bTbqGfKRTdLU5dFcyRpnRDyyZl349KYSpsQmfC2nfdmrEbnhu46IHyswPu+UUhRC+VPoTPFD8iqu2Vi128tfmyVE0ZFs9rL3WK1vH1xH
 7nwWOwDfbMUyPa6CoBTFSb08YUmb5xDdCA8GTo+nUW7Zke8W8zztD4mQkH6H4yhctUWeKHMRwta46eN81hIqmVsAuN+0ZR/KfbJVzZyz7KiM28ZQEp0A4JZG
 j2YiCLi04ohio2UXv1ZDJcWqzJfHPJEdQTVz8m6pQpA5cGs1+8VswbtRhNBvImWTRXn21MCScRXnGm5wVoeIpp/7fWeRYVWyc9IK3Sqvhb5e14IBbJVJWER+
 wgCMTqRNDwtXcWJ0AAvLTr//3yFyuabnhiIJvb0uW7cJ6jMen4vZRP2Piq5X6YpflhibBLHM9D5JRlWYWq05yuAgUs6J3CnPDKgI+uyjJBN4zkgCu6lInxPB
 2w6psqAJGHHv5CqwhftSi7oD45OXUs+p1MqDenEpgqXbTYGCj796Atb0mrsx3HwIJsTxCrKG/4uQxMqQi7VT5379SFoeIdCw2TU01pPT2koabpBD/ZtBwSYx
 hC2iJDh0x7H4A0w1QX3JrXNbAf/OtpTtw56873/RJ74E1rpySGs=

blacklisted. Long ago i needed to do that...

On 24-12-2023 20:41, chaosesqueteam@yahoo.com wrote:
> Note: This is about Unreal map support in this project: sf.net/p/chaosesqueanthology/tickets/2/
> Which is an opensource project. White people will not help
> me because, as Polaris here says, they are feminist scum.
>
>> Hello,
>> In case this is not a troll,
> It is not
>> and is a stupid narcissistic teenager who
> Also incorrect. 37 years old.
>
>> thinks the way open source functions is via extremism and horrific
>> sexism, and promotion of terrorism, I will respond.
> I've likely been an opensource/freesoftware programmer longer than you.
> Maybe not; maybe so; but I'm not the neophyte you take me to be.
>
>> Congratulations, you will not find a single contributor, if you think
>> that storming into a public mailing list spewing sexist comments, and
> "All opensource C programmers are pro-women's right's dick-chopping faggots
> as their new-testament demi-god tells them to be (matthew 19 greek)"
>
> I thought there was more religious plularity amongst them.
> There used to be.
>
> Want a religious war? We can do that if that's what you're up for.
> If you are all our enemies than we'll treat you as such.
> Do you understand what I am saying: ? Do you?
>
>> then supporting terrorism is the way open source functions, then you
> Why shouldn't one (morally) "support" those who slaughter feminists, and
> in the alternative,
> ensure men may marry female children, as YHWH's Law commands in
> Devarim chapter 22 verse 28 (greek, hebrew, latin, not english (white fuck))
> ?
>
> Tell me?
> Should I "not support" the hellenistic greeks who put the Amazons to the sword?
> And introduced an epoc of rape for young virgin child brides? (Zeus was a rapist)
> (white faggot males seethe while clutching their New Testament "BETTER A MILLSTONE")
> (english) ("CHOP OFF DICK FOR HEAVEN!!!" "NO MALE NORE FEEMALLE!!")
>
> In hebrew it's called "tahphas" btw. Also supported by the actual God you white scum
> try to bury.
>
>> have the complete wrong idea.
> When I started opensource/freesoftware programming it wasn't all woman
> worshiping faggot white christian scum. Guess it is now. Regardless of
> whether your pro-woman teachings are acknowleged from the New Testament
> or not by you.
> (hint: that's where they're from, uneducated trash)
>
>> Best choice of action would be to not speak any further, and at the
> How would that get me contributors to assist in additional map format support?
> It wouldn't.
>> minimum apologise to Jan,
> Jan is some cunt who opposes child brides and is mad that the taliban are
> raping their little girl wives as we speak.
> No I will not apologize to Jan.
> Especially since you allready gave up the "secret" that no opensource programmers
> will help anyone who isn't a woman worshiping faggot piece of shit.
>
> I'm so fucking glad your feminists have been killed in
> 1) Central Asia
> 2) Iran.
>
> Anyone opposed to men having young virgin girls as brides, deserves that fate.
>> but I doubt anyone will take you seriously
> I'm simply asking for some more map format compatability.
> I did several myself.
>
>> moving forward now anyways.
>> Best way to deal with people like this is simply to ignore. Note to the
> Best way to deal with feminists is to kill them dead: like the Taliban did.
> The only way men can get their rights back is to do what the Hellenistic Greeks
> did in their history: that is to slaughter people like you who uphold women's
> rights.
>
>> mailing list is I did offlist the user in response to their previous
>> email, which was aimed to provide feedback on how to properly ask for
>> help, and how openbsd is not a freelancing community for random C
>> projects. I did not receive a response so they obviously aren't here
>> for any decent reason, and are likely a troll.
>> Please now get out my mailbox and go somewhere else, I rather read
>> constructive emails instead of spiteful sh*t.
> Want me to physically fuck you up dipshit?
> How about you go talk to a wall.
>
> My emails are about Unreal Map support in an opensource engine.
> Not you showing how much of a white faggot that you are.
> Do you understand that?
>
> sf.net/p/chaosesqueanthology/tickets/2/
>> Take care,
>> --
>> Polarian
>> GPG signature: 0770E5312238C760
>> Website: https://polarian.dev
>> JID/XMPP: polarian@icebound.dev

