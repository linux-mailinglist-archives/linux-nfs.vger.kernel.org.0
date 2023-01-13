Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63B866A13C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjAMR4I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 12:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjAMRzk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 12:55:40 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800039423C
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 09:47:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DHBv0r022174;
        Fri, 13 Jan 2023 17:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0L4UYD/UsDcV95lxU3Cw2zI3UTKahdwJ7EMy/TRXs2c=;
 b=WCiLA3b9hnwjHXGeEAWfhus/DP/sQJ8zynHeSEHMmYMPbPUB1fv5JT+nQSe+ud+CobSa
 rtKJolVeP3zkYL4pc26xNP3mps25W/DjO9phjewrtKH7boZF7MiFB93IyCsxTIndQ607
 FoekRuKj+5hi3p5nGIV9B3Shwz3lhea4smKZ8/zAx9RlzHtbGEF4KxEi+SGJKk41Yb3Q
 9c1OO8u2IvNZr4pY3Gv5Sjl5V0UugmwaWlqCFu/f5d15Famt9nXG+xnKMyagdKbx+FIE
 UT97+/oXznXu1w+T3MXO3pPKfe+CdRdNLhhSQiqacMldOPYk2j9acNYQgRKeIDsb+OhH yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n33sph1kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 17:47:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DHWkdo007290;
        Fri, 13 Jan 2023 17:47:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4cxebu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 17:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buAgntiExPKW8fUHwWMzhzF0peJJDO5R7XN3At3+idlkSSRu9byivncy9F6lBB3UmfTxm1WYwjGnI+6eOea55juJY463cL8uceXM+cLymK0X38l4senDB3w1EM59it8Zbn8/15k0id6D21Q97Udc6Of01FtcOgsTPyQemsgBT+hCfSakZSjBZYh4ObQJHKqytUw871XO/VTKsf2BHc3R3FUmT/DlcZQw3Hsr42r73CuuArYMMyxFtM9BAmj3cWDYgg4W/53deCohpa/cFAyiuDvWuZUJTJMalVWCNv7rqiUcGYpkrjxGR4Bu/4Ou0LdGJ47DuTQ9l2nKRrKJG8hwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L4UYD/UsDcV95lxU3Cw2zI3UTKahdwJ7EMy/TRXs2c=;
 b=Z3sj1WTWMa93sqVqFtXNrs2aAinOIQIxGRuoMMj8PKJn7CFllRk/dq8wAbfQgenqHccXIZQe1P9d5kvTMJ93be+Jx2hWLNi+MsiOz9bXVogTjYPGx3jv7cO1AcV1CptvoydufkcfsXsYn9Ve2h+4RCz0wO1fCbIBqrQni/U51kWiVD5sTD/uxRO/AXCE9FDrR7+Wuc2685Zds/MfysvLJjkYyqmUZ0B7pP9Ffz7ms3PxlkQNA6N631mTDBGq7CUkqPOyC2CdffgQODt+8FnJMjuqSKpLld+vmJd5vAWJ3m+BLJbb/zaCQH1NLoXaC/EfBHXy0nnNk0bMqG8OnLh5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L4UYD/UsDcV95lxU3Cw2zI3UTKahdwJ7EMy/TRXs2c=;
 b=k9dtTRVLoSyk5qmew8ymVJouwd4t/0kzWYGD2VdxsG2hIxuaGULPxow0HyjL9QKoEgLZtSxvtUz9Tk074o0Iy7XP1bpsoYmIx2UCMFbOQi94HskIGRS+KNlSt0fMFEt2xvSW63hg4ZJqRwixgyGjo0zwEJOH1wj8pVAbGHITfQE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5111.namprd10.prod.outlook.com (2603:10b6:408:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Fri, 13 Jan
 2023 17:47:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 17:47:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Simo Sorce <simo@redhat.com>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v1 04/41] SUNRPC: Improve Kerberos confounder generation
Thread-Topic: [PATCH v1 04/41] SUNRPC: Improve Kerberos confounder generation
Thread-Index: AQHZJ2PJzwA+DVng8kujBPNLQZDcoq6cnt0AgAAAlAA=
Date:   Fri, 13 Jan 2023 17:47:33 +0000
Message-ID: <7E1D75F9-FE63-4698-8CF5-79351E3BC194@oracle.com>
References: <167362164696.8960.16701168753472560115.stgit@bazille.1015granger.net>
 <167362331302.8960.7194615871100298109.stgit@bazille.1015granger.net>
 <da45d36f18ed0f019d0cd16d2715465c3ad0a1eb.camel@redhat.com>
In-Reply-To: <da45d36f18ed0f019d0cd16d2715465c3ad0a1eb.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5111:EE_
x-ms-office365-filtering-correlation-id: 3a282725-4725-4186-be2a-08daf58e3fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dnx/KcQMa257/jzo3TnqoiiBTcjFtW0E0J68xTVShdIE/lE546qmN8p6sqWCWHbrF2JSf1WCLCFEFlzInx99efD3ZQvPVbBSZxTQodAxMBMPd/L5wRFVsvnRO752s2tOLXh/YoyrmFm2sCzgYVdFxrtm4sobf47GQ0+AjsAJKGI6wHGe7XDuZZOUveg5JqQWkBQSdU7QLBB8fP6c8/7sc5sezHStvQ24Ylz/YPut6UnlnNnfhDDNuVA1b1zZ853uYUoF7F8pqsr9AJzgauZ/xuAT4h/t5jkMhthXqr/CjzvsfZyNRGSJOuReDVl4p5hp6h4kM7tmNQyBlnFvk+rZnBlKu4EZb6i/mVC5A/S2NEDF8U0jDMpgDx0DFtfqXuIBlkfsbTYIq03NsV56NFjyCrePLIH35nObxjiVkpSO9C2ngabw6VvG1LqRyWU/OIMYdTEZYQksuaWFR7l2xSSaNvKGHHAddXZ7c/E7rPQAB2Aeq0O0wbVrgCqEv6g7qNRLUaVgeQi68pFyU3gtdNNXksQ3Zj/Jyz/GmK3k6MW83LuEEeADDkXHgO/AFHE/eNv2HCcbOvRmmQ9kNgdTSvpng05kWog39ffRSTOk9wG222qOgo+grH5TH8YLEql/AZ3o/pyqOGQ1Y+rmpCKgGiNc022uMxsoXKAmpbBY/55r17GZe8qomIhtKttHa+CvsXLaXLoNc5g7vTyjcBa8/GQhyMo13DacwDa0Bty3FyVBtCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(53546011)(38100700002)(122000001)(6506007)(2906002)(186003)(6486002)(38070700005)(33656002)(5660300002)(2616005)(6512007)(71200400001)(478600001)(26005)(316002)(86362001)(36756003)(83380400001)(91956017)(66946007)(41300700001)(8936002)(54906003)(66556008)(8676002)(4326008)(6916009)(66446008)(64756008)(66476007)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CiJnCp9dvJ2MxKF/DnZs6GO4uVkAttvrroHUszKqkyQpURY2T0iqhvcLlIrP?=
 =?us-ascii?Q?pIZ+bt3A5XynVoBV2rgG4351ea/JMXDvs1x+TdPb0TCr6fOM8+HCOxjmIXxH?=
 =?us-ascii?Q?MDy3XZx3NZmwcH4W9IbkW1o9dHk98EWAOX7OIlZIet9TScN8+XURuKedSjOT?=
 =?us-ascii?Q?qWv7UZV0UVnRr4ygHAqqUFcImYaxGaZtiE1jZci6hkrIzTbZYrYPPAELQJO0?=
 =?us-ascii?Q?Go0efwv2puZ7pldkU70is55r9q4UGsSqH9fbkIbypCkzhnTkqeNblm2hyi3F?=
 =?us-ascii?Q?BTrOBEKWD/iaDllGnQqMEFU16kRWh/HSrIDB5xpmB/6uYCV4jrme5LWv261O?=
 =?us-ascii?Q?lXBfegqbuoI7IAyOQQ1H4xoT1yWsuVDxxJT8Stw3YY68qJjedhiF7YzAzHXl?=
 =?us-ascii?Q?hmjwGI/MovQpCnsWQ1D9uvvG6r4bWg8O6+cSsdPfHvBnHSgS13xc+eQEEqLN?=
 =?us-ascii?Q?N19z6nBS+CdiLLDOAfnAyN6RhSAm2K0U/9eoTdxYIuhMwcHNRRw9SEY8/Vld?=
 =?us-ascii?Q?YjGVQ24k+aVLwNKLiLiVQ5ubG98s8MlEd6fi5QIY2dBrGClObIRJWK51oJbE?=
 =?us-ascii?Q?vEHtc9K3WwCTpo8/vJpEdNM9Eq8bgSWSCIGVw8eg2X/BS54eEALy0C8Qiz9M?=
 =?us-ascii?Q?4rBR26TGz0hRzjYrcv2caQ3rAVcGCmXV/2ldhXfOWTkMglon/zXSBUB7fnsT?=
 =?us-ascii?Q?kdpQTx9a9Usz2HK3Jya/FWHAzyysmGUhY5GyBTlZdHe71D/J14BhtqqojmBv?=
 =?us-ascii?Q?hHUJHPrp7j9hbUYiOXRyIl78sp7gYNoxYWRfo9Mm9/QX4G+P6/pBgbJWraie?=
 =?us-ascii?Q?iBhkyAU+oaqVJwkJI/i1Bak+5BWsxClIRQmMkhqr41KDBFeH6doSOCkktplg?=
 =?us-ascii?Q?LhjL/16KXsEvg2n3OreMrHTY00fp5/tcEinBcOYJ+gWF89I7eaoijpjyj6EI?=
 =?us-ascii?Q?PblnP0AeQG5lOSpN15uK7OPoyKA9lkBJXV0wfmJsqwiAjHm8P+78lrQI2k0Y?=
 =?us-ascii?Q?+HUYpdLXpqGKfvyPBr9gckDs3BxoJ/QUkHZ3tfXLC5ivv9tJf02uUdDgbmQD?=
 =?us-ascii?Q?ttvbFZZ+T1shw70W1hGXq+VJLRayp+0lGUw4MOqxs79k7+pflz7BjyOlENAP?=
 =?us-ascii?Q?3cLd32X07Hg1xIgTuOY+G0s1/GEw2kpKF+M3dZYUPcKQYWmrBKDd+gQttety?=
 =?us-ascii?Q?rlZebz7E/euEwuO72HA/kvCS1zDQDQr9TkoDaHis31ZjefvhUxv5sUwkqqvF?=
 =?us-ascii?Q?Diyj6Nro4K9GO7vwJ8n0p6UR0JQg0tU63xYk+m++uGXBSkzdc6oKjKG8PWxh?=
 =?us-ascii?Q?Hb9Fk7uMAoyUes0cgvA+y5JsGEdEND657qcmh4jqGx0EZk3UNCS8BJGFnbJi?=
 =?us-ascii?Q?5KitVAhRIuzz7B4oeJUYFc4H2xnrAI0Olu3aFzPabq/ipUfZhQ7I3QWpWFFc?=
 =?us-ascii?Q?AWEsxeajMz0j9jT6+ZpHz45NQ/bz5fmBoHAfgsUSsRuCc4vnIEuNx39AboTs?=
 =?us-ascii?Q?9wJbs7Cxi/yMfM12ZXzTlYhkh6NJ4Pj82NUi1CFMX+Vt0wSiNeVd7e8F0m0o?=
 =?us-ascii?Q?KCRpDqdTDuPGymqO82acC2LAsI09ahnKjrp9VjwqeptOiMSoUCBpuDLSuLeJ?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A17FDB5BEDB9C3448A87C7DF9AD50A07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5CY/20DL2w9d8B0Ap8I1XcAS2QCZK4x7TR4SPLShgz/mw9X+l3Pvl1eIKz7kVJcqzUmar5Rg1jzgpI/1zfDmo4OjbitTQ6KqWItYBw81y1kq6ujkCx4mRG72cmW89QwMYAbRbdZ4oyOeczmMPL7jOInQXunn6iXqMrm8gHBTPHqG1Xbvgjxj701VEKbrwumxTXPHfG4XMeSsnGAYfo16/H37J6SU9p3GE9RPOtqKys55aPjuiq/xgM/KPDTb5YVaxV33bM5TUPoYkahKXemwqMt5jW2YvqAA472JNiCMW7PAjiYUBYYqLd1uJF+GWMlraat7+RUqeD1VryAGxACg9ZrphnNCYdVCgHG/zZdhCs6QyrQQBFctPCfUreWltaDVdw5BD/G+KrxxaQap64qu9premV88PJVLNkuFxqgWLYWTcT7dyxj39/IZZ7MUqH0oGKHngTs7hMrdIwS4JcRSHRLqz4ecJai86N8ovbCOtljR2vIm84vjePIBEri1QkpFb8eIESkT0Rp0VLS0wcszrAP/2Wf8zfRyIlNqLlQUk9FMJAnlW49DhbiGBYrnffd96K2XouknkibmF9tvv0QB3SRu+PuoHJZBrcFiR+ewHMC93OwS1Zes50zR8GCM2yOC4qx9+wq+L1uAB76QYyebm5nOazeuV50k77+D7aqPsL2aiVF4VVny8EMwfQeed2+0W3/XJDlhEztG0lgjckyVJ9zxzWNfAPRjP6yVZ6djk6CZr7uFogZ2FJMLnZ6VWyPQ5TEV8DMPyIV3SHzPiYGLDvasAKq8/BC5spnrL7Z6JpXdIroi1Rqq+nwsfD29nIZl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a282725-4725-4186-be2a-08daf58e3fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 17:47:33.1535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vr86wiV20zlVfbWDg8Emk5qomlO/SYLv8g4mJ89aBcak+qQQpoJYMdtJharRL+gWxfYytnP3annAORSOgCPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_08,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130119
X-Proofpoint-GUID: Ho1ZKufmPnjLkwom_s3NN3UFnmlEFt2D
X-Proofpoint-ORIG-GUID: Ho1ZKufmPnjLkwom_s3NN3UFnmlEFt2D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 13, 2023, at 12:45 PM, Simo Sorce <simo@redhat.com> wrote:
>=20
> SIPHash is not a cryptographically secure PRNG, and is  not suitable
> for the confounder, strong NACK on this.

The seed and starting counter are both derived from random sources.
This hash doesn't need to be cryptographically secure.

But OK; please suggest an alternative.


> Simo.
>=20
> On Fri, 2023-01-13 at 10:21 -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> Other common Kerberos implementations use a fully random confounder
>> for encryption. For a Kerberos implementation that is part of an O/S
>> I/O stack, this is impractical. However, using a fast PRG that does
>> not deplete the system entropy pool is possible and desirable.
>>=20
>> Use an atomic type to ensure that confounder generation
>> deterministically generates a unique and pseudo-random result in the
>> face of concurrent execution, and make the confounder generation
>> materials unique to each Keberos context. The latter has several
>> benefits:
>>=20
>> - the internal counter will wrap less often
>> - no way to guess confounders based on other Kerberos-encrypted
>>  traffic
>> - better scalability
>>=20
>> Since confounder generation is part of Kerberos itself rather than
>> the GSS-API Kerberos mechanism, the function is renamed and moved.
>>=20
>> Tested-by: Scott Mayhew <smayhew@redhat.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> include/linux/sunrpc/gss_krb5.h         |    7 +++---
>> net/sunrpc/auth_gss/gss_krb5_crypto.c   |   28 ++++++++++++++++++++++-
>> net/sunrpc/auth_gss/gss_krb5_internal.h |   13 +++++++++++
>> net/sunrpc/auth_gss/gss_krb5_mech.c     |   17 +++++++-------
>> net/sunrpc/auth_gss/gss_krb5_wrap.c     |   38 ++-----------------------=
------
>> 5 files changed, 56 insertions(+), 47 deletions(-)
>> create mode 100644 net/sunrpc/auth_gss/gss_krb5_internal.h
>>=20
>> diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_=
krb5.h
>> index 51860e3a0216..192f5b37763f 100644
>> --- a/include/linux/sunrpc/gss_krb5.h
>> +++ b/include/linux/sunrpc/gss_krb5.h
>> @@ -38,6 +38,8 @@
>> #define _LINUX_SUNRPC_GSS_KRB5_H
>>=20
>> #include <crypto/skcipher.h>
>> +#include <linux/siphash.h>
>> +
>> #include <linux/sunrpc/auth_gss.h>
>> #include <linux/sunrpc/gss_err.h>
>> #include <linux/sunrpc/gss_asn1.h>
>> @@ -106,6 +108,8 @@ struct krb5_ctx {
>> 	atomic_t		seq_send;
>> 	atomic64_t		seq_send64;
>> 	time64_t		endtime;
>> +	atomic64_t		confounder;
>> +	siphash_key_t		confkey;
>> 	struct xdr_netobj	mech_used;
>> 	u8			initiator_sign[GSS_KRB5_MAX_KEYLEN];
>> 	u8			acceptor_sign[GSS_KRB5_MAX_KEYLEN];
>> @@ -311,7 +315,4 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offs=
et, u32 len,
>> 		     struct xdr_buf *buf, u32 *plainoffset,
>> 		     u32 *plainlen);
>>=20
>> -void
>> -gss_krb5_make_confounder(char *p, u32 conflen);
>> -
>> #endif /* _LINUX_SUNRPC_GSS_KRB5_H */
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss=
/gss_krb5_crypto.c
>> index 8aa5610ef660..6d962079aa95 100644
>> --- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
>> +++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
>> @@ -47,10 +47,36 @@
>> #include <linux/sunrpc/gss_krb5.h>
>> #include <linux/sunrpc/xdr.h>
>>=20
>> +#include "gss_krb5_internal.h"
>> +
>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>> # define RPCDBG_FACILITY        RPCDBG_AUTH
>> #endif
>>=20
>> +/**
>> + * krb5_make_confounder - Generate a unique pseudorandom string
>> + * @kctx: Kerberos context
>> + * @p: memory location into which to write the string
>> + * @conflen: string length to write, in octets
>> + *
>> + * To avoid draining the system's entropy pool when under heavy
>> + * encrypted I/O loads, the @kctx has a small amount of random seed
>> + * data that is then hashed to generate each pseudorandom confounder
>> + * string.
>> + */
>> +void
>> +krb5_make_confounder(struct krb5_ctx *kctx, u8 *p, int conflen)
>> +{
>> +	u64 *q =3D (u64 *)p;
>> +
>> +	WARN_ON_ONCE(conflen < sizeof(*q));
>> +	while (conflen > 0) {
>> +		*q++ =3D siphash_1u64(atomic64_inc_return(&kctx->confounder),
>> +				    &kctx->confkey);
>> +		conflen -=3D sizeof(*q);
>> +	}
>> +}
>> +
>> u32
>> krb5_encrypt(
>> 	struct crypto_sync_skcipher *tfm,
>> @@ -630,7 +656,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offs=
et,
>> 	offset +=3D GSS_KRB5_TOK_HDR_LEN;
>> 	if (xdr_extend_head(buf, offset, conflen))
>> 		return GSS_S_FAILURE;
>> -	gss_krb5_make_confounder(buf->head[0].iov_base + offset, conflen);
>> +	krb5_make_confounder(kctx, buf->head[0].iov_base + offset, conflen);
>> 	offset -=3D GSS_KRB5_TOK_HDR_LEN;
>>=20
>> 	if (buf->tail[0].iov_base !=3D NULL) {
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_g=
ss/gss_krb5_internal.h
>> new file mode 100644
>> index 000000000000..6249124aba1d
>> --- /dev/null
>> +++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>> +/*
>> + * SunRPC GSS Kerberos 5 mechanism internal definitions
>> + *
>> + * Copyright (c) 2022 Oracle and/or its affiliates.
>> + */
>> +
>> +#ifndef _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
>> +#define _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
>> +
>> +void krb5_make_confounder(struct krb5_ctx *kctx, u8 *p, int conflen);
>> +
>> +#endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/g=
ss_krb5_mech.c
>> index 08a86ece665e..6d59794c9b69 100644
>> --- a/net/sunrpc/auth_gss/gss_krb5_mech.c
>> +++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
>> @@ -550,16 +550,17 @@ gss_import_sec_context_kerberos(const void *p, siz=
e_t len,
>> 		ret =3D gss_import_v1_context(p, end, ctx);
>> 	else
>> 		ret =3D gss_import_v2_context(p, end, ctx, gfp_mask);
>> -
>> -	if (ret =3D=3D 0) {
>> -		ctx_id->internal_ctx_id =3D ctx;
>> -		if (endtime)
>> -			*endtime =3D ctx->endtime;
>> -	} else
>> +	if (ret) {
>> 		kfree(ctx);
>> +		return ret;
>> +	}
>>=20
>> -	dprintk("RPC:       %s: returning %d\n", __func__, ret);
>> -	return ret;
>> +	ctx_id->internal_ctx_id =3D ctx;
>> +	if (endtime)
>> +		*endtime =3D ctx->endtime;
>> +	atomic64_set(&ctx->confounder, get_random_u64());
>> +	get_random_bytes(&ctx->confkey, sizeof(ctx->confkey));
>> +	return 0;
>> }
>>=20
>> static void
>> diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/g=
ss_krb5_wrap.c
>> index bd068e936947..374214f3c463 100644
>> --- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
>> +++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
>> @@ -32,9 +32,10 @@
>> #include <linux/types.h>
>> #include <linux/jiffies.h>
>> #include <linux/sunrpc/gss_krb5.h>
>> -#include <linux/random.h>
>> #include <linux/pagemap.h>
>>=20
>> +#include "gss_krb5_internal.h"
>> +
>> #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>> # define RPCDBG_FACILITY	RPCDBG_AUTH
>> #endif
>> @@ -113,39 +114,6 @@ gss_krb5_remove_padding(struct xdr_buf *buf, int bl=
ocksize)
>> 	return 0;
>> }
>>=20
>> -void
>> -gss_krb5_make_confounder(char *p, u32 conflen)
>> -{
>> -	static u64 i =3D 0;
>> -	u64 *q =3D (u64 *)p;
>> -
>> -	/* rfc1964 claims this should be "random".  But all that's really
>> -	 * necessary is that it be unique.  And not even that is necessary in
>> -	 * our case since our "gssapi" implementation exists only to support
>> -	 * rpcsec_gss, so we know that the only buffers we will ever encrypt
>> -	 * already begin with a unique sequence number.  Just to hedge my bets
>> -	 * I'll make a half-hearted attempt at something unique, but ensuring
>> -	 * uniqueness would mean worrying about atomicity and rollover, and I
>> -	 * don't care enough. */
>> -
>> -	/* initialize to random value */
>> -	if (i =3D=3D 0) {
>> -		i =3D get_random_u32();
>> -		i =3D (i << 32) | get_random_u32();
>> -	}
>> -
>> -	switch (conflen) {
>> -	case 16:
>> -		*q++ =3D i++;
>> -		fallthrough;
>> -	case 8:
>> -		*q++ =3D i++;
>> -		break;
>> -	default:
>> -		BUG();
>> -	}
>> -}
>> -
>> /* Assumptions: the head and tail of inbuf are ours to play with.
>>  * The pages, however, may be real pages in the page cache and we replac=
e
>>  * them with scratch pages from **pages before writing to them. */
>> @@ -211,7 +179,7 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offs=
et,
>> 	ptr[6] =3D 0xff;
>> 	ptr[7] =3D 0xff;
>>=20
>> -	gss_krb5_make_confounder(msg_start, conflen);
>> +	krb5_make_confounder(kctx, msg_start, conflen);
>>=20
>> 	if (kctx->gk5e->keyed_cksum)
>> 		cksumkey =3D kctx->cksum;
>>=20
>>=20
>=20
> --=20
> Simo Sorce
> RHEL Crypto Team
> Red Hat, Inc
>=20
>=20
>=20

--
Chuck Lever



