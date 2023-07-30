Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3382768910
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjG3WQq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG3WQq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 18:16:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC910F2
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 15:16:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ULhgP0009283;
        Sun, 30 Jul 2023 22:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FjMyFQfsD3ZxVSAzF4tyMe+VbALM6fWJ2JpYgvb3E5E=;
 b=OR+TJhDqFgIopQ0wA6ZgmmUfP5WlAOeTc8kHeMs+BCDwR5VuRPWf5Z9PJZffiHrpMZ1f
 0eRStzg/i6+bVKHIw6yjKpt6IYJCV+OR6X+wGHUxWuKrw0Pmu8kctRGXF3c3dOjtXptN
 KmdvV5e1pLtkAmJU0Hbchr27IZEC2louxQhc1KGL/LyBiC+33Si5xGfPSejcltnBywYY
 FW0x7oI2nXEWQLPRfARHB0vtslU/Hq7H/gmcyd7ZTZLGBdRalzeraUQGw/5qMYiGqj89
 1GXU+nfeM1gm4358uPEvLPiBBaMogkWPsZ7djlQutkyEm3u/CYzEpt+KfSzKymvNkI0M QQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc29ffp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 22:16:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36UKJlNu000613;
        Sun, 30 Jul 2023 22:16:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s73mkpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 22:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgm1JvqztkEYq0q34tViuaYSfMP8M2Wbh239jNFkR96jFD+IJiU6PJEI16Vy8PykP1vPKmnJeqsNZGni6wpIMP0J7ntB0BwNpPKLIK+dZbuz1hZpCVbCQT1K+ehDN8kTMYvYUUWM1sRUZqBibuMZOlrUy5Z4OqXRMbb6t8oQBauhaB+INJNtHi2dpeZM1RJXqOQ25BzSJODeNZDnCDeth67Uav5ftTiGfI+Elkyr+bZO5MBqtRgJq+ROaUwOTuY2Z5EJXN4rt4NmOw9BtlAeMjhHal1TiLqKvQZ2HYKq4WleGLPyYfOo/mV7c8AF2kXYm4XFM9lndjBGiU4Cndgmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjMyFQfsD3ZxVSAzF4tyMe+VbALM6fWJ2JpYgvb3E5E=;
 b=HVkVUfHO5m5cb2Pc6NNSQzqb5P1adpPhd3Xpo9ZB6Lk/Xyp07XqmQ3yUAo/3Dt2oHv5f3S2Ec/0tGJZms4T8PvSdRbVGY336IbH73gzSssQzDF3+G0ZYeJvXlU3bYpwoMi0Lo+FBT/GMJMJUTBSZtuVbsP1KnYM2ApU0RzB6HQd76Z3oBqWTACAPkFCAwIVOWGX2z3BXmIWEH3zPgOeBecdHNaTLGrWb27gMPHttX7nskIvyZ2FVcnWwFYo6axAh9PVPk4bOkv+XEVpgn402vOMa0Wrgikr8uyy/iPwGNBiOpJrOzi/d6aqEp7mwV+clvE0GV/D6F76LmwQ5P6eCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjMyFQfsD3ZxVSAzF4tyMe+VbALM6fWJ2JpYgvb3E5E=;
 b=EZpu6V6LjqlqT/u7CcsLXAY+7F22MI/2rO4JMX9DdFod61HnpKaE1+H4zNt5V7SMyeMiLSG+qQkNMu5DZn2nmcgl788S+iZyKaLWKkG3ep0ldlE4wKQ0NeK1cvzV/x4hMWfIxtaY8nfzTYODaJKWPFRCRChBejoIOXtlJnH8fBI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5815.namprd10.prod.outlook.com (2603:10b6:510:126::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 22:16:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 22:16:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 06/14] SUNRPC: change various server-side #defines to enum
Thread-Topic: [PATCH 06/14] SUNRPC: change various server-side #defines to
 enum
Thread-Index: AQHZuUKeUhPN688TTEazI3MFmgB5Iq+/h5sAgBMC4QCAAGiQgIAAAM+AgAAAkQA=
Date:   Sun, 30 Jul 2023 22:16:33 +0000
Message-ID: <3C1680A1-A0FF-470A-85F4-2813BE286CC2@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228863.11075.8173252015139876869.stgit@noble.brown>
 <ZLaVtpLf1k2Ig5Kz@bazille.1015granger.net>
 <ZMaIWPyEm83GaS0q@tissot.1015granger.net>
 <169075508761.32308.11692865993389725826@noble.neil.brown.name>
 <169075526174.32308.13675913011176702739@noble.neil.brown.name>
In-Reply-To: <169075526174.32308.13675913011176702739@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB5815:EE_
x-ms-office365-filtering-correlation-id: 885dacd0-a6ca-4bef-b0b5-08db914aa1ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YpxKaLVvUD/8Nbk3UmhR1YRdYrsmnRZqfVCwXKQ0BN3ITmdNwve5r25gD23mSbDo2LNHEbIfaw3J426Pucq0OIKfOqjN4VLHtkILX6wvZLYRP9/UZXhxCOm2HZqGMduiTUX+xaEK5RfCE6r6Qj0KAcUvE7DySNdRZa2eaz2ftXgAD4dIh++v+dK+J/dTc5tlJ9Uc+gSGaPWd4jwmWJPYoqPvClaY5J5IUbd6z6UPuT3aLCz3blvJUnJeber8pLcLZLhPgeNCWILS0ln/Bx2QfcfshKDOw08IyVbA/akwqiqbioog/DDVWQVFgp/AayeUii8TzEgbslWZYiOxUxoaQqRMqP8dWwyjwdwNLsUM0D8Fcd6/I3zyXPhXDRc9I4wMXHxwcXyYlIPA+GOXuoEyYgOkgWl6IMUN9XfUEALQMkcbXQCtOS3DrBINlkYdna2Tq7z+pCcjtuZnhdCgyupgQ2Ag/8D8wnQSTyZcDUfJp13iDrI0YpAMAOQeWqKAUPSpE74clttDrhUo6mVmverQjaIzTFGUSz/dkRPuBlE3FGTRCynt0yTLRAip41Uifihn+Xy796x5aEzd8GJbY9zoXlQzx0i3phgzhdcknUlgsjyx/ZCv0bm/xrVOjbXzzi/DBsXDr6GaIwZQZ/s2ZHx7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(2906002)(5660300002)(8676002)(8936002)(316002)(4326008)(6916009)(64756008)(66476007)(91956017)(66556008)(66946007)(76116006)(66446008)(41300700001)(2616005)(38070700005)(36756003)(33656002)(71200400001)(53546011)(26005)(6506007)(186003)(122000001)(38100700002)(83380400001)(6486002)(6512007)(478600001)(54906003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ah/wQ8aImPlvc2213tEB1w3HfjrogwSn9oA9HqPM1suyjzXPEvaLdWuPBI65?=
 =?us-ascii?Q?fHVlsMKmKLTjqPruOICUG6UR5K7HP9GvWHM6brM10VMW9QAtFm1iSu8dADlu?=
 =?us-ascii?Q?L1/6uAcPKKyjpmrNVDZVL+0CMYaSQFqP+4pShD2oFFRS/HRng3ODTI5NBwHb?=
 =?us-ascii?Q?ezGEOcTLQtXyoAj2MQYBz8KMwfZqEHRZ2X5lekwfydBgZOIZE7RgxiBR8qsG?=
 =?us-ascii?Q?e0lLuKDqrIUDQxhDC63O8BY+Gw5COLYEXw9ZqldckQQRnv2qnaAYT8X2biCL?=
 =?us-ascii?Q?NdCJCJlOR0DkY/JuZUDLDzknhJoPQ/MtyzlT5XIPhzn+uBEbxePmMFDlscmA?=
 =?us-ascii?Q?DlF2HVmF7DvcyWpK+f3z8DbUpuesC8c1+/NaOJMaYfOcdU2ytRXjLV6SFGiH?=
 =?us-ascii?Q?lA7OqQWKGlegIpwuqrTw2YYpmDKCxGsYk+FIczy1sTHkZ0To89kRAkS3G4Ta?=
 =?us-ascii?Q?K6/9T844unAFtXiUAvvjP0OVFS3fbdqvJxCQCmwdvmfi3OHNl0SUx6XBQxCq?=
 =?us-ascii?Q?nLkKG7lHjl/D2YafOP9dFEMaG+3i2b6ctlS9aIRwe3yzIJhEcexTQ7VVO1LV?=
 =?us-ascii?Q?1qNGlSCHZJercqBLREcIohMebHDzKWuZdVb/Sqry4k38MteWQJfHm/ykPBhz?=
 =?us-ascii?Q?Cx4BpcTH1nFLc51/K0wdQpxUOmiOuELB4lhWKiycNFHP6P6BGi+s7Pm982yE?=
 =?us-ascii?Q?CiKH1Q2DfrAEUZkpJNvJjJSQFbVXA3TM8NvcfS8gRMhIXfdZoY2EeuRyefw1?=
 =?us-ascii?Q?Uv9ZLmeUiiKX6hTtX9X7ypnnXh7GvlBToltSSsOtx2PoXed59z1F4YsuaqrY?=
 =?us-ascii?Q?lZLylnS9c+40Fr3mIoGbXxCYHU8s/qu0PVcV1ff0t08pzs+KkzOtdDW1xTAH?=
 =?us-ascii?Q?Um8YHhtB/8tUgIz1DTq6ubb2aN0Jf04Zr8K8je0LMSp4sa+3qcD5nj62FZz/?=
 =?us-ascii?Q?7iU7NdnxC6tId18GgA9229wKKgZd2kFtDKCBdjC2xU2Q8AzqUVmCpuyvtooJ?=
 =?us-ascii?Q?+JyyIrCWls4PwtNNRAryqHUYK2AFprE8rO26VWLFyziD2ejtYr1QBIqeG07L?=
 =?us-ascii?Q?yWhMu0QQW24pZLkZABaKoTRgqtzoGKJcxjBKmA0xXYfeJOI7v6xfoxRR3xTa?=
 =?us-ascii?Q?qFNuXLrfS45AdHUGybNrcLr9QaSaGQl/98tpno0ye+BPXUPtkUaMmDulawmx?=
 =?us-ascii?Q?m7zOJSsoxMq+92tTmugSQey9e3XzAyXqL/xSU65AC4ByoXnxw2mmtdreJxt6?=
 =?us-ascii?Q?57Ic9HdgR6dH2awZaC3iK0YR365gmBj6v4H+toUxcaakr0sLibXKNBSjyZHU?=
 =?us-ascii?Q?rMcI1wON0mODXhDnRpd0gQgvgK3UvSy4wj1+kWGEjlC0Ds2WWQxEBIQctuy7?=
 =?us-ascii?Q?qLRmhmgJC4FdyvhwKIXYHs5qr4hpmBztgbmCunKoGPP3XRjF6N/Kxvn7P7Vj?=
 =?us-ascii?Q?eEBL1CZwwO1CMCMNw3Bgl+73XVL1mQOgiLVoTzXlouLh83vFtYDt9sX1HKrY?=
 =?us-ascii?Q?VUFT8aijrPqQe7P74uCWHzd+WJ5cudSh+G+wvgCuKD1B/YILlUCVTmBUBRPa?=
 =?us-ascii?Q?MYceIIP48ZO0CAb3mtv/ylKMqhaERdKJOfA/+fuRQ/J8iW+tqYx5bNMeMO6O?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2F5AA598EE499459CA7231A739BD486@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GKy8ihEd20urJUTbs+eJixp8X6IF2fx2XBtGTTF6FbUsSCXOpKRbYmKkcyk9M1LjgWMTp5PrJbYZglL1RGveLeJBaTKPis6xOrGyQa5PqJAXNowl+9UHgRMtVkJTED1T7DJ2q7LQIrqYaVLD09P6V3e/VTze9Z/hVgjQy/ZI4ktYvgVtJYKcnl0fddDrlQrCk3hk+GyMVW3TRxLLRPEQPum6q3YEKBjMRf+PawT3QnhVtAzR28cB64vNBw65Qz7V+ZXuPZz8YUvTQzVTZwYmDJyu7xisxxY6uaaXOpzX5pgpNVYO+24skhFnCL9Yld1uF8FTFnvv9oxzBJRUiWVMJhjfse2UQBPAfnVCmD+iokv8Zee3eiJnbaF271fkvoXXONKED1DHvNGz5eZ+EMEnTw2Wbhqb4mdlIxxc01229XtTJjEgFh7wYBI4xaZ+hVWcBQ+G/avzDnbIoGFYuWtrVDjaHJT7tUZ4cjFbI5i/H/u1ABT6OfbBtJ9IH00ky0ODUwQ5G0Kfom331fShnqNwgW9RKW8AaMrRuRXYVxoTwt9bDCDNIgvFqY2K7Es9Arh865KYhU1dSE4fmm3OiccSm+8AxpjvHNwVLHowITZqKZyxTGWGzWgsmjzNHhK1kzL8X8YOhhv9zXgwCfl3lkoTcpiSq2EMyvGuL466nqMe5oTyb92LGSNg+oVo4J8PRsC5u2PTeoqBCAIMiaQcVZqee7rkLMlEmKTK1KDjnHxGE2+hfokhyJVGu2vYvVaUKqgN6eoTv+UIFRxQRnwAxW1QJiR0SHvia6sW8QB/kF9guBJ4LkgvSZ5zNY0aJNfdWqFl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885dacd0-a6ca-4bef-b0b5-08db914aa1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2023 22:16:33.3262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bky1nsq84v/9MPiTiDU6NG5XgOMCnjyFo/Ts+ditRyqaIFzVcdH3YFjkXKZmHOPqIf5a+eCrshQhQYE4y3DR5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=770 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307300208
X-Proofpoint-ORIG-GUID: M_cmuSaD0yLHVJtP_wySnLh3E2WPdhPz
X-Proofpoint-GUID: M_cmuSaD0yLHVJtP_wySnLh3E2WPdhPz
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 30, 2023, at 6:14 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, 31 Jul 2023, NeilBrown wrote:
>> On Mon, 31 Jul 2023, Chuck Lever wrote:
>>> On Tue, Jul 18, 2023 at 09:37:58AM -0400, Chuck Lever wrote:
>>>> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
>>>>> When a sequence of numbers are needed for internal-use only, an enum =
is
>>>>> typically best.  The sequence will inevitably need to be changed one
>>>>> day, and having an enum means the developer doesn't need to think abo=
ut
>>>>> renumbering after insertion or deletion.  The patch will be easier to
>>>>> review.
>>>>=20
>>>> Last sentence needs to define the antecedant of "The patch".
>>>=20
>>> I've changed the last sentence in the description to "Such patches
>>> will be easier ..."
>>>=20
>>> I've applied 1/5 through 5/5, with a few cosmetic changes, to the
>>> SUNRPC threads topic branch. 6/6 needed more work:
>>=20
>> Ah - ok.  I was all set to resubmit with various changes and
>> re-ordering.  I guess I waited too long.

It's a topic branch. Send diffs and I can squash them in.


>>> All this will appear in the nfsd repo later today.
>>=20
>> Not yet....
>=20
> No, they are there - the top date looked rather old so I thought there
> was nothing new yet.  Sorry.

There are some old changes in there already, but I'm still testing
the latest set.


--
Chuck Lever


