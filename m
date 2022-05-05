Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51E851C23E
	for <lists+linux-nfs@lfdr.de>; Thu,  5 May 2022 16:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380536AbiEEOXC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 May 2022 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiEEOXB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 May 2022 10:23:01 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2052.outbound.protection.outlook.com [40.107.66.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412CA53B7A
        for <linux-nfs@vger.kernel.org>; Thu,  5 May 2022 07:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7Psj8ay6w6yBe4/BSgFGrrrVndonMVXk1gsSLNuY5oZupVtUCbBBfWa7xuicRHjhlm46czXShQ3eJXUfUZC0O3JBAnAAC1FIewN8Jzz5EKRloCQeZJfy/QKwp7Wuys/3NK3b6Qc6QolaMzGMTwVtfkLUqTzHm50Ud9L2ebtRnaiQC2f75uAurxzu2nqlOqPK0brsHXoks/CCxITesw5mzVoW9tSfCDv8o46ool3wd5fszlnuv1CdkeZMZO15yAcA2ZeNyoeQC2GNZWWEagaO/8llmD9Ecx+0sqtWB/r4H0jc45oXcM8VZBrj98cP0k73StRN6nu5MZNmcx1zWFD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLh9qa+X984CoK5ADUe/zjtWuQx2fRDSUsSzVehImYE=;
 b=XS3a0APz+04Bu5RBdShp5SgreyGcfyhD20fyY7/TPyCwr6/5dug3NLlEWNYdNSIyO6PPAWBBrD5FdNMYRqhf+UjSBfu9FiYG5K3WJULB7mzNXiBi84UtS484dcY6slcY+jlXzqDVMt+yGBXXpXxJWbdjdqLzNNQs5d3ghV3SFTJ5o88Fp/BGW8Js84eZzGJ5ucf/xK30G1MjHtpm7bT5dr6o5Yf4x8zEGChb625vwIc56q5VlrD7ZruJcCTtBDpqMb/yv+D0BpQlz+7VzbOTQK1AjSTEZ5dvGXJgSn+nYGJ2Um+Ij3YxYe89FT1tP2dsfOfcDzIg6vqXC5HC7zjDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uoguelph.ca; dmarc=pass action=none header.from=uoguelph.ca;
 dkim=pass header.d=uoguelph.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uoguelph.ca;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLh9qa+X984CoK5ADUe/zjtWuQx2fRDSUsSzVehImYE=;
 b=VNwiGTkoydYcIPSt05B9GaF3Cb72yM/+Xfb+288s/lOTejAeO7VwjsOWXgpMjGzyGJ1JKHsIf3wHR0hyp/h2vRC0nrtch3ZjHu5J3d0JBv/v2NhyCVVwgDZcAT9AOlgNild6kCxHu7l0UxqdpnINrvClv+2u8SNIjjM+SnbA0NZameuu5734GOvwJ2LdGuZEbI8i6xiHOE5dhEzmQAiv8G4l5icqCGmHQr+vEa1G6buGttL8PeX89Wq3wJdib2p8MiO/KJAaY7DiZMaCVhp89hvYWIcmm/F4/graHydm/806VDccqFDAQnhjGsqs/QTjYYqILdAgBHUPTT92eZKJkg==
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::14)
 by YT2PR01MB8165.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 14:19:12 +0000
Received: from YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003]) by YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fdb1:ada8:7af0:3003%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 14:19:12 +0000
From:   Rick Macklem <rmacklem@uoguelph.ca>
To:     "andreas-nagy@outlook.com" <andreas-nagy@outlook.com>,
        "crispyduck@outlook.at" <crispyduck@outlook.at>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
CC:     Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBKAAqD3gIAAWlqFgAABfw+AAMzyz4AC9oCjgAyG2mCAAJVvRA==
Date:   Thu, 5 May 2022 14:19:12 +0000
Message-ID: <YT2PR01MB97309F3F3B856591D633162CDDC29@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
References: <AM9P191MB1665484E1EFD2088D22C2E2F8EF59@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB16655E3D5F3611D1B40457F08EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <4D814D23-58D6-4EF0-A689-D6DD44CB2D56@oracle.com>
 <AM9P191MB16651F3A158CAED8F358602A8EF49@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <20220421164049.GB18620@fieldses.org> <20220421185423.GD18620@fieldses.org>
 <YT2PR01MB973028EFA90F153C446798C1DDF49@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220422151534.GA29913@fieldses.org>
 <YT2PR01MB9730B98D68585B3B1036F6EEDDF79@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <20220424150725.GA31051@fieldses.org>
 <YT2PR01MB9730508253381560F79E96C1DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <YT2PR01MB97305156E841831C4093CEF4DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
 <AM9P191MB166535ACBCF1C301EF900A858EF89@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB166592CDF7C78BD68CC153498EFA9@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
 <AM9P191MB1665FA51F62F82B006FD97168EC29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P191MB1665FA51F62F82B006FD97168EC29@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e2a0b11f-5f50-40e2-6bc5-65de4ac41c91
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uoguelph.ca;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e0fb8f8-a287-41e0-6b7c-08da2ea23a4f
x-ms-traffictypediagnostic: YT2PR01MB8165:EE_
x-microsoft-antispam-prvs: <YT2PR01MB816511673DB90321D2CC5312DDC29@YT2PR01MB8165.CANPRD01.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3Xp/BMpIP/t/dZcH/9UnMPiGhSYNUpjoMTe+PIqYQy2ZjABHXNgA+Y+9wNstZqbajwzbSmYHkvFPmgHudSuc+uIOIKzjMCtaEBG8Aj0PTf4P+JDG9hSpVwgCBsO8i+JjoCXm+GLd41LZa2u2vTwdlyRJNzGky/qjuEfLxXrq7BbAhddrACZcYmCdEKb4v9cclHDoa1yQS1/ijzLg7yfeOFa98XbdsPtQ8H9CttmJxyIY7xvlXNtJfnfkHdLoPTt9+TqZWt5WsNUID1J+jrmM0fgtXHZ1EZm2t3YPN/BYdxPW6NOGRaIV8zpW7c9y2rsA2e9ah46YNwAFW9SmiBOX62aH3JJU0y0AJwi8AHFr37VjfZoCFDO9afC5P+8IE0YwyFe7Iwm7EVkGonHDD1cwkKmgt7Kcvu3X9GB3RNxEvugN8BUBO+PsJJgiJiAzf0Mk2qZQFRupAAIOjDZhsmfAs5eMWjd6Tcr4/1PoSiIrE+nSy7zdrJXd8UmOpdgCyyTjvhn8Rn7WEWqiNqLhXXoC/3pfhjMvqZTdt/eMjqY30XbuebBeu1HRj/d7iZSx3nZR9pFTnx5xinzP+c1p+dvnL08ZT7aWN8Kend39oRqN6WXDtZFpU/Pxq7VyLKZFfxkdXCcQXlhH8irCejQKWsTKctXO/wepJ+uKqdlPrCUd0lPoiKPGwCcNH9GTrzuu/yNpZr0aG8rKRcifbvqNK/pOj3gvju9/gTfC9mYzUfL10y9XxVMoui03wWe/hMuDLUMA1D7UlBCPzi9qPqyoaLhoxrnTT/jNay/duO75QtrZgk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(7696005)(5660300002)(6506007)(83380400001)(786003)(53546011)(186003)(55016003)(966005)(508600001)(52536014)(2906002)(8936002)(45080400002)(38070700005)(86362001)(38100700002)(110136005)(122000001)(66946007)(64756008)(66446008)(66556008)(76116006)(66476007)(4326008)(8676002)(91956017)(9686003)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z6xMjymIYC8G7NiI/E2ZsScYoOTaP+4FfR6ET7aoLWULlekzrpT7hw99tq?=
 =?iso-8859-1?Q?UPk3NX5B+NnvBPBVPspZA+t/rEbp4HbfmvAo5ctA/NFdQ5ZpOnKL/7K7RT?=
 =?iso-8859-1?Q?xibCLFPDTC1tuW/RH+iLTnzGD5JP0avISGoV7N2hWaH0MuYGF479SxOjMx?=
 =?iso-8859-1?Q?RMRgDsB5YM8wKKfGmshmyHdl5rlSqzpqBSkU1cJSBoE8ypYdwcX3tBfZQI?=
 =?iso-8859-1?Q?amG7i5hu2IzgamsAPGM9dExJmAY6QTcGZsy6pnCBgpzTWpE/nQBl3J94mk?=
 =?iso-8859-1?Q?AMlfM1fYv3Fg4wOY6o6sYb0ljdoIbb+WpSZGAMXklgWAdVx4aLkxVNxHet?=
 =?iso-8859-1?Q?A6o3bh5ETam+knYpbf6CNfD9cWaEx/eP3LlyvsoBawEVty/wuwTzFcX9Q/?=
 =?iso-8859-1?Q?dWu8zjZPTF3osOTDWIo+u9edpgVDzbVizhF4etkFgUZahKVQkTh9+DbtNe?=
 =?iso-8859-1?Q?HIFSU3cIRz0jmkTxXQUVI2fc1haCZZF0x9Skv8q+GAGSAUq7PpOptjOH4j?=
 =?iso-8859-1?Q?pxjNWtkoUvPtUg6bC+UL9c92JtxSw85Khh6moj/8YLxPpX334FUonFipQb?=
 =?iso-8859-1?Q?Q0CyWvWG0MJs8A1e42AM7rTkibGfBiI4Uw3XDjuEgLNqlk5r0tbhnSef0f?=
 =?iso-8859-1?Q?qtj9M/rWYqMMV9Fw41HbBCQJd/KLCh4/5rT4iSx0rY0IVlDtRVI99PVdmF?=
 =?iso-8859-1?Q?dbCe3bdRYGYW+WqdElEQp8xHJVNUNlOwZsEBtFHGfKHRqHg0Hl+2JDuYxX?=
 =?iso-8859-1?Q?+vHuJRH2adtXRLDo2O8o/JxcJHlXoFpOjT6s29mNDgePWXydsHWAQ4FsgS?=
 =?iso-8859-1?Q?juiEPYUjdTN49J4njhA7mVSTav7ZfvPIYginXiJdgHSOID51/JcLzTISov?=
 =?iso-8859-1?Q?XnMvxwfEmkWsgtLPKgIq/1nICgW9xNrNGDMivPqKO8141beWsztuALTya/?=
 =?iso-8859-1?Q?0pjGnHiBP0tDmv8e1GvSvw0XhQojk8U35P9davvLVFlv0bFXZK6Ut7qTf4?=
 =?iso-8859-1?Q?v+YTzFTHXdzAjwaP0UeKgLhHGkzPm4BaL6VJdE5TYjvltGvpdrn3pZu1GE?=
 =?iso-8859-1?Q?CsFRa/ZN4uq55GP+XhJD/IQovwGpwaBLciOJ2KgiICKprW+M0mij0mqcSW?=
 =?iso-8859-1?Q?OCjo/YsAhPa25jkFf2tt/GW1zsGF+RyDZRMl57WS+hKMKZNMxeUeYa7DwR?=
 =?iso-8859-1?Q?1RmAzyH8WVxoby2arXJHaGc5cwzPnscM1FAZy0IFSQS7UkXnjv43qpjBdl?=
 =?iso-8859-1?Q?4tcJMMomHyaPSiCn1Lpe4IBR8eQlHDKzw63O7vWLVVSYhUuLwiYmhoysbh?=
 =?iso-8859-1?Q?cbn/5ka6fCChB/32UgUJgw//S35QSXh58y2C5X/uB9DLRmjVNw+fJHF1hr?=
 =?iso-8859-1?Q?Xkuk2fy4Sm99aSmgRXIHz5hBU2tSSVUpgsd0Aa/IX74dOygaWKWjKgDNTg?=
 =?iso-8859-1?Q?CqwMKLjy4WyCo7SNw6rHxWOYQx8UZE3sA2OeAyP1ARjCiSVu5107xaqZs/?=
 =?iso-8859-1?Q?33rHp39YLNV78Y4A9jrFqIeN/Xsy4A85oBl+8Z0SGgfzNACRgICIQTyRzG?=
 =?iso-8859-1?Q?Ql4GN+Jq736VYLl4WYkcytKfcGSHlm9DAh6EM0WaxgL86fDFOvQvN0Ol/H?=
 =?iso-8859-1?Q?EvWAdCmq34t0g/k6YAk72NqTNZsLJbzPVNAoZdFSptYjklTKBKLqdP9jSt?=
 =?iso-8859-1?Q?3zKFbe8h5vQo7CqZztKYGAaS9f+DkHtIybFvJEmcyB6VIfnVDmSzuQSZ3p?=
 =?iso-8859-1?Q?m/9MfdAPl5YeHa+vinMvgWLHndHakpR/Qe7eXGA5zo5zdVGqLpBSOdzXx2?=
 =?iso-8859-1?Q?m7pEJmfop7PQ5/Bunhy/MAJfVQZf6urnNxFUeqH8nXe/OUB2QqPWyn2gUV?=
 =?iso-8859-1?Q?T5?=
x-ms-exchange-antispam-messagedata-1: XcLSXULzZsx5UA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uoguelph.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0fb8f8-a287-41e0-6b7c-08da2ea23a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 14:19:12.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be62a12b-2cad-49a1-a5fa-85f4f3156a7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIzuKgn2x/q6fzNwzWyGK5U8ooKVrR+UDYnAlLBF8iecVcy6EbGGNrUh8sE2Sp4otURos29XLJGM7kZgm/rWew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8165
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I took a quick look at the 4.1 capture, but did not see anything=0A=
that would explain the problem. There appears to be several=0A=
Read requests near the end of the capture that do not have=0A=
replies in the capture, but that was all I saw that looked unusual.=0A=
=0A=
rick=0A=
=0A=
=0A=
________________________________________=0A=
From: andreas-nagy@outlook.com <andreas-nagy@outlook.com>=0A=
Sent: Thursday, May 5, 2022 1:31 AM=0A=
To: crispyduck@outlook.at; Rick Macklem; J. Bruce Fields; linux-nfs@vger.ke=
rnel.org=0A=
Cc: Chuck Lever III=0A=
Subject: AW: Problems with NFS4.1 on ESXi=0A=
=0A=
CAUTION: This email originated from outside of the University of Guelph. Do=
 not click links or open attachments unless you recognize the sender and kn=
ow the content is safe. If in doubt, forward suspicious emails to IThelp@uo=
guelph.ca=0A=
=0A=
=0A=
Hi,=0A=
=0A=
was someone able to check the NFS3 vs NFS4.1 traces (https://easyupload.io/=
7bt624)? I was due to quarantine I was so far not able to test it against F=
reeBSD.=0A=
=0A=
Would it maybe make any difference updating the Ubuntu based Linux kernel f=
rom 5.13 to 5.15?=0A=
=0A=
Br=0A=
Andreas=0A=
=0A=
=0A=
=0A=
=0A=
Von: crispyduck@outlook.at <crispyduck@outlook.at>=0A=
Gesendet: Mittwoch, 27. April 2022 08:08=0A=
An: Rick Macklem <rmacklem@uoguelph.ca>; J. Bruce Fields <bfields@fieldses.=
org>; linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>=0A=
Cc: Chuck Lever III <chuck.lever@oracle.com>=0A=
Betreff: AW: Problems with NFS4.1 on ESXi=0A=
=0A=
I tried again to reproduce the "sometimes working" case, but at the moment =
it always fails. No Idea why it in the past sometimes worked.=0A=
Why are this much lookups in the trace? Dont see this on other NFS clients.=
=0A=
=0A=
The traces with nfs3 where it works and nfs41 where it always fails are her=
e:=0A=
https://easyupload.io/7bt624=0A=
=0A=
Both from mount till start of vm import (testvm).=0A=
=0A=
exportfs -v:=0A=
/zfstank/sto1/ds110=0A=
                <world>(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D=
74345722,mountpoint,sec=3Dsys,rw,secure,no_root_squash,no_all_squash)=0A=
=0A=
=0A=
I hope I can also do some tests against a FreeBSD server end of the week.=
=0A=
=0A=
regards,=0A=
Andreas=0A=
=0A=
=0A=
=0A=
Von: Rick Macklem <rmacklem@uoguelph.ca>=0A=
Gesendet: Sonntag, 24. April 2022 22:39=0A=
An: J. Bruce Fields <bfields@fieldses.org>=0A=
Cc: crispyduck@outlook.at <crispyduck@outlook.at>; Chuck Lever III <chuck.l=
ever@oracle.com>; Linux NFS Mailing List <linux-nfs@vger.kernel.org>=0A=
Betreff: Re: Problems with NFS4.1 on ESXi=0A=
=0A=
Rick Macklem <rmacklem@uoguelph.ca> wrote:=0A=
[stuff snipped]=0A=
> In FreeBSD, it actually hangs onto the parent's FH (verbatim), but mostly=
=0A=
> so it can do Open/Claim_NULLs for it. There is nothing in FreeBSD that=0A=
> tries to subvert FH guessing.=0A=
Oops, this is client side, not server side. (I forgot which hat I was weari=
ng;-)=0A=
The FreeBSD server does not keep track of parents.=0A=
=0A=
rick=0A=
=0A=
--b.=0A=
