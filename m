Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8360550DBE3
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Apr 2022 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiDYJES convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 25 Apr 2022 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbiDYJEJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Apr 2022 05:04:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2104.outbound.protection.outlook.com [40.92.90.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A621D0DF
        for <linux-nfs@vger.kernel.org>; Mon, 25 Apr 2022 02:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epPfszWFDhKR42kDuzZXg9fa1p7vRi/rgqPea6tu1B0Ax077GIDkh8C2vZnrv9lNXjtmgBeiG4bgyg4C/vFX/aF629l32KYybUW2i0aHG1senytrHCw0vUNY2NjS5QPmhe3qjvGhIJnsJc4UG5F2bTDSJzuKH4z4zOb2bR626oTegjXkpIT+VuE9AJRgs9BscWUuimnRLEL22xQKkPhKCAk/5sMtFQ45+HagHCElShPYsoO3Mti7fSnoM3AB6HS9L1JBESPpUdIc0twZxLOaoEiEHN+F7kUVi8vtld8Mqg0N44yBM/WIGXGqH5lRhuRlZlTb+/J3JEbaLERFD+EqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCWsdllkM4GgHnXDuJhth3C/+NzLeyc1Yic4tSkp8aE=;
 b=dV3nt5SwTdiI7aMsoWERmnzWaFsu730Dq5TOHIKGY+9sHPVO4R3Ej2bqoCMjSLO2R4lC8xjtP3uOzg6sAHHA3xt6mxyiXh0rd+OlHPfy3c+n29F6n+xcclpZ90sgCruLiG80YSsIwePeRTql1am5ZmrbtDmGX5NscAIU4twEFPajS7RJwjsgOkJAGJUXTFkXrOIRV7aNdpcLNP0Y4BpsfXsYjnuuEmbyJ2p+fF6M1aEE50o1FOQoqIrs+S+6LJ6eqP6mvVbi4X8RVXep3qShDjxDZ6MQIAjKcbVsj1zgXO7X8utZ1NebS+Z7XayidsgLWzxS4uHtqsHMyEznkCdGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:267::24)
 by DBAP191MB1164.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 09:00:29 +0000
Received: from AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a]) by AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
 ([fe80::543a:843f:f401:da2a%5]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 09:00:29 +0000
From:   "crispyduck@outlook.at" <crispyduck@outlook.at>
To:     Rick Macklem <rmacklem@uoguelph.ca>,
        "J. Bruce Fields" <bfields@fieldses.org>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: AW: Problems with NFS4.1 on ESXi
Thread-Topic: Problems with NFS4.1 on ESXi
Thread-Index: AQHYVOLTJWvLLebuJE+8fGO0gJ9faaz5zdx5gACo0QCAAAJi6IAAGkiAgAAlUYCAAE6KrIABBqgAgACBbBKAAqD3gIAAWlqFgAABfw+AAMzyzw==
Date:   Mon, 25 Apr 2022 09:00:29 +0000
Message-ID: <AM9P191MB166535ACBCF1C301EF900A858EF89@AM9P191MB1665.EURP191.PROD.OUTLOOK.COM>
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
In-Reply-To: <YT2PR01MB97305156E841831C4093CEF4DDF99@YT2PR01MB9730.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: de-AT, en-US
Content-Language: de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: f7806e50-ff43-82f4-e9b0-11037c1dc02b
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ULFhqQQGycLnmmK+Ur8+udu9ecdigZLU]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41e2f6e-feb5-4504-d7c7-08da269a0c1b
x-ms-traffictypediagnostic: DBAP191MB1164:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PsftnxxQFF+Ysv8iONN0Y3OHn35uz5YUnFEiChwasFfkpGZCuQxIluwOrEbQ+C2UbmpiUaeE79wFVip/OKOnTLfSCYSAUBUY3ACqPR9u6OG3T2XKbwb4pyj+nq9trG+kMq1XJn2CyKea6PD67Ew/jXypPm8yGFy9GxjltuTTTgYXzfX6DrvCxlaUv/BldbQh8EG9537jqrlW4VMTG6t/om+dkxgu8WcbYOqjKtc7N1X3raX9rvN+bkR7te3WjR2FZFzydrNNUfJ32PLqZ5qyNaRh3N2F5ovPIufi7rSyqonLXOQYCSkY2i1A8T06TUvEWyUxyHTI0tBDRwhucLumB5m3sk6gVrGBjmx0BdWA2DSUpGzNfWSkjtPRcieVx0j4zxeLfwf6N5WV4NBQspb12IEDLdCaVu6IIWhxCWzA0MSZwDJHzRRq+k3DRoiNhcted//9Dsl7ACAtwBVUkxtp7Z8AIxU3YL9sqzkHmO98EGcecgsQYjnlizcnuC0JgdSWVUvaKWfMOIArb28KLSKsGkmi16CaY2bpEG41jp3mtQcOXHux1VEHPnEqNp0u7TwQkgo16TD4UzfCUxqRh1co1lU7TuRlke6lLMrVdHoljjqpWK/up5NGv5f2S1oxbSp
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dF3LtYChKC13c6rC64OOp0eu+751iGc/Nvq3p8kBLd0jFyANVXB4TN/9IK?=
 =?iso-8859-1?Q?xrOv9Qdg4lBO8SqjljnCR6L/JWGMOstVELTsEuzZ0sOqFKjjuVB3KpqRzq?=
 =?iso-8859-1?Q?Ok9/QlJwm/b9zuWEysWnQmc0YlGKVogE7N4ZwrTWZ7E+rRHnBIA1DZWh7G?=
 =?iso-8859-1?Q?O9Z1QmOA2Rap3NbvpsYFlO+OT3pFLl/ZnlE+hLbVwf8qRomEFPUegIpZ+v?=
 =?iso-8859-1?Q?TjmRpmRmPBScvDs/bx7MJCN3a9kRnDKk4JHq53k6v9d/ND6fI6iSoLCtzp?=
 =?iso-8859-1?Q?pC2gkl542EK/xqOYXegPaxMRShjEetQNhzSm3SM0i0b/3bDoWjhPwsXg4H?=
 =?iso-8859-1?Q?ftHiQGJRgfftYYnwzTKwuTBDFWB1CrSKy5QT6sZhxLrSNz8Fyhx1AbPaaC?=
 =?iso-8859-1?Q?ZAYVmrQ5XQJVdANSvPonmGJtfjNrstywKXo6XZcosUSjt4tnbRO9ZdvAqy?=
 =?iso-8859-1?Q?wnukOIIG/ItYT9md3qWVLnblaV9/A7E4bmhuKvpP/FMWSHEwe2Ln2s9Fbm?=
 =?iso-8859-1?Q?sfnnFNU8mDWHmhM7SzTHKTzwZ3AAMYSTyTDxOjNCqk65pbwOchto6EudNx?=
 =?iso-8859-1?Q?2zzbl1ouLFJeuCrOnQHFwbAEB+Pnw7Jf1jTiJSMVgfWQkU0hCANX0RhOPX?=
 =?iso-8859-1?Q?B5UKOTvxXVulUpjRI9E0WhXRJkg49ODKyz87yZTvaZcNNd8MLAYHuGzLfI?=
 =?iso-8859-1?Q?8U+1aiPcfdRUVO0NByh1zM2SNhh4Cfj5NIJY1q6aCQFj3FgV7m7bGvkuKW?=
 =?iso-8859-1?Q?pNlDH0DNPqTlLqnL3CmP0C/r0QJj8uqRaE58WLx/nVAtVgkAUR4VMde+cp?=
 =?iso-8859-1?Q?afsiTiw4MqpM8XJLqXOfFLVNbHCmYtRsAMZml3wuI35oEfLnJuyB3fWww3?=
 =?iso-8859-1?Q?UvurYIZSnlee8M2aScXuEFu4fn5pOuHBk2dW+eiaBB24ciA6qRQjIpxM8Y?=
 =?iso-8859-1?Q?RdRJjrSXWV7Ideab0UPjngtvcXnjp3GLVe69qSl63VUsXB9tyJtkXSkmTD?=
 =?iso-8859-1?Q?6YqYrS83T19GAysRUWPGgsG/byEcwLFCWC6cgoAvzq0k5MpMKVQaFPcY27?=
 =?iso-8859-1?Q?ALKcKGS9mo9/VmP9VewpxXcT+ofdLKtfqGvSkj08jqWCN/Efp5ybX9JsZT?=
 =?iso-8859-1?Q?R1ojkKl1zwkGBqJ6s01Sa1niJ1lGLzCcH5KdEeaqDRxOSSvaFA/Ytm/o0i?=
 =?iso-8859-1?Q?5E6sm7/7gQR+VbtVRzPZoTwgk4J3/2HKJP+S4YRI0u/Xd8IpC6175JZDcF?=
 =?iso-8859-1?Q?TSB3yWSE09YIvPM3Bo+dRCi2sMnza73pVFhpIGCN44fYe7Kua//bs1FRlX?=
 =?iso-8859-1?Q?jvDgPtZSqr/YdETqD2acoINTIaxXOO/TY40lPwUSFByPe6tYO9rFQ5XlfY?=
 =?iso-8859-1?Q?YRRZ2clzpHR/264IaWLWdy3Ejhg6tBRtXsYlqaubmggEwTn7wMbGPVyp1i?=
 =?iso-8859-1?Q?IgqOPOn6BU+4E8dIgh1vdP0YfXn/A8Qs00gC0t/Z9R5zEDHSBAyxuiL40K?=
 =?iso-8859-1?Q?Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P191MB1665.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d41e2f6e-feb5-4504-d7c7-08da269a0c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 09:00:29.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP191MB1164
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have made some more traces, one time with nfs3 and one time with nfs41:
uploaded here:
https://easyupload.io/7bt624

Both from mount till start of vm import (testvm).

NFS3 works, NFS41 fails.

exportfs -v:
/zfstank/sto1/ds110
                <world>(async,wdelay,hide,crossmnt,no_subtree_check,fsid=74345722,mountpoint,sec=sys,rw,secure,no_root_squash,no_all_squash)

I tried it now many times, but was not able to reproduce a "good" case with nfs41.

Tests with FreeBSD I can do when I am back from my business trip, As I need to add some disks to the servers.

regards,
Andreas



Von: Rick Macklem <rmacklem@uoguelph.ca>
Gesendet: Sonntag, 24. April 2022 22:39
An: J. Bruce Fields <bfields@fieldses.org>
Cc: crispyduck@outlook.at <crispyduck@outlook.at>; Chuck Lever III <chuck.lever@oracle.com>; Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Betreff: Re: Problems with NFS4.1 on ESXi 
 
Rick Macklem <rmacklem@uoguelph.ca> wrote:
[stuff snipped]
> In FreeBSD, it actually hangs onto the parent's FH (verbatim), but mostly
> so it can do Open/Claim_NULLs for it. There is nothing in FreeBSD that
> tries to subvert FH guessing.
Oops, this is client side, not server side. (I forgot which hat I was wearing;-)
The FreeBSD server does not keep track of parents.

rick

--b.
