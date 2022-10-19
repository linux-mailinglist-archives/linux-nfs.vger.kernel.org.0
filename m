Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5BD60390C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 07:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJSFEi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJSFEh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 01:04:37 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 22:04:34 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0645EDF14
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 22:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666155875; x=1697691875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OLZDgCizAE4V7Rl49pAOg/MI/MHAxw3Hu0VgxmSr7RE=;
  b=iYkISd4Kt9pPV+/Jhe/Rs/jTQJH4+2VIwlVJwHOqJ8mQfjAbd97aYPRg
   1zSWhZ2T+rISNs1pzSsWxtWaKJdzqHwU3foADqbMDk1gRGPXmGHDkM1Zu
   ezxeXMHELlgIUaNfb/9KRfWQLjof4FvTVxV1qpqd/2FUIejtQIPYCMfHq
   m6btSC85hoxbVbEXfrAhVBQJA0YNR/Nt53lCfyOKkctJGrrJtKMrVxiaT
   PzzN8kmfycNUh01ZC0I33yedxeNAoMfSD3fHZvwr+7valXRHzSYPc1Emt
   NwcWmlJQUQ3DkVhmXkplSoPytHj7S1lxgN4w3p8+NEEJFzpZ81uUmTxT+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="68042352"
X-IronPort-AV: E=Sophos;i="5.95,195,1661785200"; 
   d="scan'208";a="68042352"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 14:03:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pzo8sC1MkgJLp+W2dD5O+CH+OMm1hRKSQtqfBzguB7eUjGf83sqHWInh1uuGThK8MEQfpm7JWjWfem6lvnX583ZHaiaHWejyEsj6uOz5/rgUHaWC7WLAwiAyaGw6EoXEX9PsivixLgUGi4JSEHiISsREWWHTpp9Vm/SS7zP7odkahr18Wdgjq2Dti8vMJS0glhhOUFl/iuQ9nIQcgbaR7zjm/Un5VXPN8eNJpybn2O+QRaIUUkNqMWAP5h6cqkRNtzpSQVFKYuoVIBSH3n6ErMoZlu7Zu6WlDM1C05cQpfe5HEYXFqzlMjwgPrfwE9gBrmfsEvy2voJiKBT31S5zXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLZDgCizAE4V7Rl49pAOg/MI/MHAxw3Hu0VgxmSr7RE=;
 b=c15y20il8mTeAeAXUoUiwWWwFRkrGd2AkOGmVcCkEFCfDSW7h7nREKQmFvvdiKDk/CusOkyFLHYRfzz7A143rqRFyBQv50hD+yoLDf3nxFArxC8VKWu0yBImVJ/IOr0cYbvvYYRcxll7LJg/HC2hPITgMZNoeNGlDRNyCkry2x/QdOnMMwyFyBPgs2nIuD2qerjfg257A5zKosS47iQRUAmRSxKSHPONyO1oSj/vqukMoYZsqq9Qcr4BctsuIf5a6CAH/HQc8DlVeXSMqio3w78uu4v/a+yagVwB/HJsM83/mbOW4UDZQps3bLnLHtDrQQFuKDoSi9xHuIcEAfXdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OS3PR01MB9303.jpnprd01.prod.outlook.com (2603:1096:604:1c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 05:03:22 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::93a:c1e5:e19a:6272%2]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 05:03:22 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Jianhong Yin' <jiyin@redhat.com>,
        "dros@monkey.org" <dros@monkey.org>,
        "dros@netapp.com" <dros@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Jianhong Yin <yin-jianhong@163.com>
Subject: Re: [PATCH] merge python3 patch from fedora nfsometer package
Thread-Topic: [PATCH] merge python3 patch from fedora nfsometer package
Thread-Index: AQHY4sfV2V7M09FcBkKndHz/4XBo2q4VIEnw
Date:   Wed, 19 Oct 2022 05:03:22 +0000
Message-ID: <TYCPR01MB84552E9CDF45A8AAF6EBEE0FE52B9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221018075946.283516-1-jiyin@redhat.com>
In-Reply-To: <20221018075946.283516-1-jiyin@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 59bbe4e173fd4498bdfd9d75307c6a1e
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-10-19T04:26:57Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d010a60a-8317-4326-bae9-9968fc513a0f;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OS3PR01MB9303:EE_
x-ms-office365-filtering-correlation-id: 86802a57-98de-4a34-8e1d-08dab18f3f5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/ChjXQ6SZ9vg7noebB84VBXS/M59u9BYjda2MieREVe8dqGJE2jVER4qdEZ8MmkV0MWIzIysASB0u+PmccjrsghlAHlZu6BnsLZWB2THnemcFMSYXNcTo5tVcxSi+2AtXUvPmGTqEMq1ekEdJwo1mBUj87zx+lVQAwwqSqdm4tIt4z89sYPUu2+AQUkwfaYqt0BxYyAq16Iek/vUyzEf+Qb1aOAZaefjCm/0jVYrBO5OxUnhsbT2Umb6vxDgUlKTpIS4l5Rm9wCOhWgz65SQ4ozD8aRlrE6MZIY+D4FNdtE52Sl6Q0l7U0X7sJn0U4A3kh9YqvDPHcR2kH8ccFwtp1a7LYtjdgKjcQHvhV0np0luEqiRerhENXKnjuF0PEXbPuAa4gpJXq3thqvMLgzKvSwvLGK+iCUV+PtpLhfUc3GqdEXC2SNVi4bcBVLSlK8X0zOw34ujNtV4h5NyrHnq0tdC0ci9WaRvwJ9xgJt3TDj/QGfO5yPv/8Cc5En7FyHMjyTMbSDYfaz8EF1zj0fm/ehYDL/0zdPOQY+QXpFpP1tRGxEIoSFw4redFWdsi65kNGgFkvnZRH3pnhMYN64lgkgbcGsEQWsslMpWtzW9k8VBs+5P4Myw3aERW2o13WMBkpQR4raWpeqsi8fjF4MK8g5GI434ntbJvCv8HiMRxp7fR1gL1QxaN8GitsxVV9Q5/h/TtV+mcN2RQfYuQdZuiI9IUitp9TQIrbsUCUhzD5mNebmien5llAoIJ7l6sf0UQVWsMGp29jniQEf7sDymYlqggo6UH12juFIS870wjAmVKChHxR2tko+szO5iGOrfyIAfee0Gr91Bml+bmvSLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(1590799012)(451199015)(85182001)(1580799009)(86362001)(122000001)(38100700002)(38070700005)(33656002)(82960400001)(478600001)(8936002)(316002)(110136005)(186003)(9686003)(54906003)(6506007)(7696005)(53546011)(966005)(2906002)(55016003)(45080400002)(66446008)(66476007)(66556008)(66946007)(76116006)(5660300002)(26005)(41300700001)(71200400001)(8676002)(52536014)(4326008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UFhlcXB2SFhlU1YwVk1tRHV4VGlabFZUNnVrb2NFUWkvMXNMcWtEbW9Z?=
 =?iso-2022-jp?B?K3QvS3FwamREMnE3TytwYVJjS25waEJNRU1TMitpV2c1eHFxcTBESS9r?=
 =?iso-2022-jp?B?VXN4MTlLaFVOeWJYcHRmWHJZZHJrN2x4WDBRNW05Yi8zVS9PRlFEdnBP?=
 =?iso-2022-jp?B?YTA4dmh5NGdoYVNleUQ3OFd6NFNVSWF2MS9KbFVuRjkvY1ZDamJXTU1I?=
 =?iso-2022-jp?B?OHpwazU3dDFlY2ptR2M5SEtJdWVJVHFVaTFKLzRDeWg3cm5Gam9NNWtz?=
 =?iso-2022-jp?B?ellQYkNZUVVhd05sQWZQOXp1OVI2anlwMVVxcTlrL2t1N0ZLaUtMTXJV?=
 =?iso-2022-jp?B?WkhGbit3WWRtbmhyWm03WFB2NElJU0E3bm9lZ2x1NHJpaTBCRTYxMnNv?=
 =?iso-2022-jp?B?b1pQd1lUZ1BnOElwQ3Eyb2FOckp0VVBNVXFZTUs0NkptWUNJblRtTy90?=
 =?iso-2022-jp?B?b3hNcno3aDF0WHFFVTdMYVpUZnJ2aThvWmhjU3pRSmFHZVlyZTJ5am1v?=
 =?iso-2022-jp?B?bWs5eEkxdmM5R3d1ck9JUVI2VkdLeWRPdGlwc0drd2pYV0lxc2lkdzhT?=
 =?iso-2022-jp?B?cUF2c3VBbVlOYTViaEhCNW44OGJrQm5TUkVLbERaUDdtQ3F6TFB6a3hK?=
 =?iso-2022-jp?B?amhZUzkyV0RFRFh3dTJTaEtRdkQ4R3J3WTlLQy9CU2hMbkxKQktmZWNp?=
 =?iso-2022-jp?B?OFFPTFU5UFVMSGtONUowZ2FMK2grWHhnNUZyS0dockoxdCs1MWVSSDRu?=
 =?iso-2022-jp?B?dklUZ2d0RUp4cGRZOUd3YlZtNmZGNU9Ub0l5VnZvK3F0TWErbmN5d2h1?=
 =?iso-2022-jp?B?Qkd3OU1aTkJoaGRVWi9tUGVEUEZHdC8xYkM2RkFJWEg2SnkvWkwrWEZJ?=
 =?iso-2022-jp?B?ZjA4dEFlS2gyWktPU1FLT3h1REVhdlRPU2liRzFna0xMTGtIRGQzbUUw?=
 =?iso-2022-jp?B?Z2dwSFk0OTlia3M2TXFnSlpxV3d5OThEbkhzSExrampYb3lYdmRNWTg2?=
 =?iso-2022-jp?B?TER2elVZQkdPcXpkQzF1dW5NMFNVQjlWQjAzZmpoelphUVBic3IwSlVp?=
 =?iso-2022-jp?B?WFdBdUROYlJ6WWF2SWd6cktSSHErNERuZDBpenBpY1FvcmZKcnlOUGRj?=
 =?iso-2022-jp?B?WHlOUGM5VzAwT0IyRGo4NCtKcXNvdE9ZWW5uNWVvWml3dy9UaEN3MVRV?=
 =?iso-2022-jp?B?MU9hcERBUXcramlxNU05QmZCNjhJTDZMQVFUR3c2YllXeVlwWUF6ZEhB?=
 =?iso-2022-jp?B?aUdmbnlWNXNUbU9DaTJEVjhsOVZoZmxRRDRSYkg1UHF5NWFkUXJJdUJa?=
 =?iso-2022-jp?B?ZkNJRU9GdGEvTnZYVndNZDhNV0MyQVZuZ3d2T3F6U2FJS1AvOGdJODJ2?=
 =?iso-2022-jp?B?THFDMzF1ZUZ1WkdoUUR1MXduQW9zQWlyQnBzWHNQN0wxc1JxRWpFeGZn?=
 =?iso-2022-jp?B?Ymk5RkI3aG9nZFkvYzJyd2llRHRZc1dQQ0wxNXF3SnRMN0lQRXU0S3Yr?=
 =?iso-2022-jp?B?V1cwb3NqTHlDbFdKWUVocmFUZDlZSnkwSTRqand1bFNkdzluUUs4YlZV?=
 =?iso-2022-jp?B?ZzViNmppVU9hTm1qQUVRQmJ1N2FSRU5HQ3R6TUllektTY2F3K0JmMnJs?=
 =?iso-2022-jp?B?VWlEd3BWVVZuMUxJczdMNHAzUTJ3OUtMak1xTjNqWEh6c21waU1zQ29X?=
 =?iso-2022-jp?B?KzdpemM2ZWJidkhNc2N6KytRM2pnNnhLMEFab2lEaUFPZ21iUHU4K3d6?=
 =?iso-2022-jp?B?YVBvMXl3cEc5eXdKRFN0WFFId3I1d1Vrd0swVUxXdEZBK1lPdFdCb3Bt?=
 =?iso-2022-jp?B?VThmNk1QWk12YlZzaU1PRzdwWjRUYUY4ZXV0L1NrcWltNTFESG0rOExX?=
 =?iso-2022-jp?B?Z0tlK0Q5enJmN2twWkM4U2hVZTYyQlJEUEpDdEE5MFd2UDNQV0FJRUVL?=
 =?iso-2022-jp?B?dnE4ZkdQb3JNY01BV24yVUtTUXdXMFdDRFdMdmg4YWxiVE5yVElvNWIz?=
 =?iso-2022-jp?B?dFpFSVB0cmpwRCsxV0JaUE5XQ0hNeDdSSnBsTnV0OS9OZnZFVkhGOEg3?=
 =?iso-2022-jp?B?TGp1RURZalJVQ0dtWm81cURLNDJYUWhGbVo1QTlCRTNBS3paUCttb0k5?=
 =?iso-2022-jp?B?cE40YU52aXlndkVtb3JkU3FPYzlkSlNQSXV5cHhMemRlOXJJRGZZRTdM?=
 =?iso-2022-jp?B?TjN6SUxNMjJiSVlIY0t0MlJWTHpwcHBJZS9WakJTUXVmQ1JPa29XVnRV?=
 =?iso-2022-jp?B?ZDIxbVQ3Znp1c09heEFPQllhcmEzbENJTXpqSmp1eHV1czU1M1RxU0Ux?=
 =?iso-2022-jp?B?WC9Tais2UlZ2QTJHTXNwa0c3YkNaR1lxT1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86802a57-98de-4a34-8e1d-08dab18f3f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 05:03:22.7216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G78W2dWWCNJt951nw/dCnYp6KeOnutcMN8dXSACrKjlLGWwFkGlfHG0tIHXpJgm9xmZreqrAfagSQHU/FeiHAYJVG4u6LC5AXcpqEHqQXRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9303
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 18, 2022 5:00 PM Jianhong Yin wrote:
> see: https://src.fedoraproject.org/rpms/nfsometer/tree/rawhide
>=20
> nfsometer upstream can not work on latest linux with python3, just
> copy the python3 patch from fedora nfsometer pkg back to upstream
>=20
> Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
> ---
Hi,=20

I am afraid this patch will be ignored. It seems the maintainer has not
responded to contributions at all in the past 5 years. The upstream tree
seems not maintained any longer. There was another developer who tried to=20
send a patch two years ago, but he got no response.
Cf. https://lore.kernel.org/all/OSBPR01MB294973D46ADE4ED7A7D3E19AEF880@OSBP=
R01MB2949.jpnprd01.prod.outlook.com/

I believe nfsometer is still useful in measuring performance of various
NFS settings. I think this patch should go into the tree to let people cont=
inue
to it as python2 is already removed from some distros such as CentOS/RHEL 9=
.

Does anybody has any idea? As the software is licensed under GPLv2,
I think it is possible that someone create a fork and take over the project=
.
Is it possible to contact Dros (Weston Andros Adamson) to ask if he is
still willing to continue maintaining nfsometer?

Daisuke

