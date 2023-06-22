Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC473A90D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jun 2023 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjFVTjO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jun 2023 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVTjN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jun 2023 15:39:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9C199B;
        Thu, 22 Jun 2023 12:39:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MF6tnp020719;
        Thu, 22 Jun 2023 19:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Le3Uv2Q77f8+UU89jjRiXDWcQoNlrb0DrS12v8si5nc=;
 b=sig6FRrdfgSuSi2g4RxplOUKNUaxX9hOOHSzDmly82hkhHd3PeWUSXzP9ToWYE860dwL
 DRgRQTxVJv8MzDItMMilX0c6rwHg5eqqQQCKH+78vMIGpk9r4Or/vNVlxzzB7o/c4UKA
 rZc4jqahnjHuA0x7z3VU6+9vDmO/H7ziF3xrXfCkRbX2OtfxQ7uMSkCl89fmU7YXJf6V
 w7CX1FX49J5D5XCsZkSLCpYrugaot4rXS1RKTDhGqmDBBHug2v7uNZ3n2s80M8+sJmDF
 w/j/WGRP4VyQlW/iPzHjXkiwGYytsy/x1QkQtF9JuQ9YPSWT6LVSTnKW78Ly0ivceaAt UA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3tr98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 19:39:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MJ3uwt038633;
        Thu, 22 Jun 2023 19:39:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r93981hxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 19:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZJM4DRq2ln4ZpuZ5sSBUntz97MpAEtL9fc09jubmSdQLpApyzce9iVhFR+rYyNTrbN7icWL3hYbxIMWU9Bh9qZ/i8Bm9paeXtpygD5Ibl53MrKaQyXj0t+rVd2V5yBvaRUlRCMx2CsBrnt2blhiwcyyGMcfH8lk4ZeNyAuM4+ZCzaqfrNyCfK6WHj8feP3vSnUR/JIVCrgc7tnC8MXN3NOYEq5bMNq3eH9kBLNwWBZw7VUI6LSq1goUnk+MYa9dKc9XzyO5jWbyOalGIxEX2Il3KWzRg9A6Ss+niynjSxCNwv6+qc8SqkX7hOeL0qFY7KGbx33Q+WL/R6nJBahMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le3Uv2Q77f8+UU89jjRiXDWcQoNlrb0DrS12v8si5nc=;
 b=gDF8/qGCKe6A7Z5AVZSZiRR7MFcYj7AuTeL7is4U8GSZYjy+iLLYml6kKE0W42U/Vs2BA+DSg4wKb2l0GluzimSMslfSBgalY9n4SUUfrIolPJnTprVIp7Iy316+BOt8kiv5JmbiXmNu+364YvWXJjV7DQcRQZryIjCIzk8zAqTg9OwnmDkfm0HQxYKHyRdEf924dWNKp0830MWFALdCPNHo4k+MJLLKY6LMjE9jy48UkrukQ4d8bXbuN4qm7oJB5uQ5AM00Y5hwvl780FNst2k8iA6P3mUV7K/igt7OB1CdcZs+rwWL3sdGF6tVUi9hL8OGQEjWRFf1//ItB+GWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le3Uv2Q77f8+UU89jjRiXDWcQoNlrb0DrS12v8si5nc=;
 b=paWCdSjQKnok2ADSdAF3obxCZj7/1fo229DY4bigZg8CMMWVBzA64wIkLZDcxi/Khs4IT7tWlmDfJIaoJ/ZayQM/FWz+p93OBJ4hhw7yYHtjy+nzAmCQTeAJzlMwYHITvtNJjlLClGrBpW8wh2ufajsTxXLFbamrY43H/1yZT50=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7379.namprd10.prod.outlook.com (2603:10b6:930:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 19:39:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 19:39:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tejun Heo <tj@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: contention on pwq->pool->lock under heavy NFS workload
Thread-Topic: contention on pwq->pool->lock under heavy NFS workload
Thread-Index: AQHZpFS9Q4z69UfUdkyWw4ptMMUQRK+VxgUAgAEyXACAAD0DAIAABE6A
Date:   Thu, 22 Jun 2023 19:39:05 +0000
Message-ID: <36C8F75A-7C84-4D86-A721-6BCD6001CAFF@oracle.com>
References: <38FA0353-5303-4A3D-86A5-EF1E989CD497@oracle.com>
 <ZJNrht3NlLyPn2A0@slm.duckdns.org>
 <CF5AF0E6-5213-489D-87CD-8E8325A6560F@oracle.com>
 <ZJSfsvFtC_d265M1@slm.duckdns.org>
In-Reply-To: <ZJSfsvFtC_d265M1@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB7379:EE_
x-ms-office365-filtering-correlation-id: 3c379399-31b1-4f86-9ede-08db7358570d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axEksuopfE+0lyIWA32jfo2NhhXtSpbMW63T8YUwnfgOJQxNiH8nEhPbegPOcNY2ZS1uYSDA6cmNiMe0k2V0mlgu2SjWXaPKsmhOkB7ZFiBJVKW+lekbu3kfb0P46VplP8O7qRNyBsM2mImIYX13hsVx8cxd5mqUAg8UqMUCu0tYEcapj8l+6fjIlnmppz1IAt01nzkxTYdisn66v0Vq2zuqUOjwH33T5lb21/JIUg2APgcvyiudx7nxfkVqAEyrqrNhoZwytNh0weff4pwhzZPjkF9foU4YUQV/CtOSbY+4t8rCv1x99QcQTSrShp0vq+tLiUARsQox0lg0WldTcwr91fneSKaaSL5xnYh11/bfqmWaE1f6xwZswHHlP1QSvy/9iwKE6WOZId6LWsjGvre/hGQBMD+tdo8ZO1YYhZO3KY+3IQKl0OwolTvLLggKBtwvNNQqVaH2HEkKYeeDEokchc0pocboEqJHw72Bmip0akjY0oRnjl7oFUWtWVRbb4DOmuKF/sABnUhLFFSddBHRk7gS1MgCAN1BAv+dO1T7xWfQZ1BD1QZ1XHR0MWv5366cYccMcIM5kBcSMkR0Ci2f+0q1iwIS8s8sDsymM/coGFdB9LPzoJHrM0HmuZ5S5tUIp0koV0ckR8I6Avrluw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(38100700002)(122000001)(5660300002)(53546011)(26005)(6506007)(83380400001)(6512007)(2616005)(186003)(33656002)(41300700001)(2906002)(8936002)(36756003)(71200400001)(6916009)(66446008)(6486002)(38070700005)(4326008)(66476007)(478600001)(76116006)(64756008)(66556008)(66946007)(86362001)(91956017)(54906003)(316002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R27cAMfPuz+QDuuWO3uk5pHuRt9vOrDQJpAgaM5xdT6NfMfey8CfPDxHDYwZ?=
 =?us-ascii?Q?+KuUb4AoxTToonbtpZOl5RqEpw3wc5rLOQxxpmZ5M3E38DdDq2s8PFx+lbAx?=
 =?us-ascii?Q?MR6NjskVlot8Pp0oc4kGvXVvKRFVM/0cFvRHFf/6wikxULuKdbLHy7mmnr0E?=
 =?us-ascii?Q?QRLmfS0Ug6u6hJyDRkOwK8YQy8s/LMmOZUuJ0i957UmyKZeQLYs43Yfod6W4?=
 =?us-ascii?Q?W+znyBLmFc/23zP8XftidJkGML5O655jIsNUvWyDBoCZ45JFsyrvPHAsfHDI?=
 =?us-ascii?Q?yzABRzx6h5VyeaXwQJZ4yytnfqndijFtfpzoprcUcDRSBJk407BdOq4vN/KX?=
 =?us-ascii?Q?NUIpTgVAAzvd+CYP64nGBVCBCxnnupz9Grbdx1zbtp+ysvGAMNUUEajde+D8?=
 =?us-ascii?Q?dCu3S4/2PceBF63i7tsdiAlDuO66fb2DNAIkB0G08lyX0CZZ9vR/TFXscxVh?=
 =?us-ascii?Q?CvEqtut182s55XKau75SwKUgm//4jcz4h4jjYLAV4zYfZZCNIQoWlpLpAU6e?=
 =?us-ascii?Q?+ibARTbwdly1AD+DaBIcrL+WsmsRY069vi0VvVmrO7R4hNooSFYA5Vo5ORS1?=
 =?us-ascii?Q?71djV9TqFCYQbqhOCSR3aoI9kXrMGHfAcjviUOCDex6Tm9Jt4u/2UKIMG9jV?=
 =?us-ascii?Q?Zi9IbCT5JNtiQisMS2P/fL30bINUxNzdV6P3NZtkqyUYSRF2zadXMpP7aRw4?=
 =?us-ascii?Q?eMOzhrTVJreQLAWPLDKZzJVMf4EVi8UYSdNHVun1Dms0ttqemicQa5c4XwVV?=
 =?us-ascii?Q?/lP/AVAarBYFI3A1+LxiMAWqBbIc7fHvqlSYO23j9kN619D0sAgetSgzvmiz?=
 =?us-ascii?Q?Z3T3OSVltvHRqObM05INvJJ0hjPGRpxt1TLTZPgpSt/A8DBcEIe6hZwJjL+u?=
 =?us-ascii?Q?EPLD9U32cyKs+FwSifuFp0zAbe59bViqh6wVaXY7iaSWATJ8GaCe7DRDmks7?=
 =?us-ascii?Q?IFj4WHo9VWjLPmMQuZQ4u/wDQzsXcJmVMuLyiWX3DjDJwSl3gM0iZsSKbv2m?=
 =?us-ascii?Q?CXV1sfII+/ru3H4LNftoJWamz8YCeTInGJLkBBRYkdlB1zHggqnO1U7fy+0y?=
 =?us-ascii?Q?C0gmNPijeimJR4BP3c3sI81n+qCzecCppDyAoY4NEpvI4YQTsYe4+tPWsThI?=
 =?us-ascii?Q?dLojjEjkI0JzFCafFUmKnNL41Fu2k3L7cDv4po4vCXVd4itZbkqgavNN125X?=
 =?us-ascii?Q?3TxFoYhJ9kTYWd3/z+NcOTXNjlEXwFn8DmZmC3BSbY/+uXHuq4mloTbIMip5?=
 =?us-ascii?Q?CFWLsKNW0R1I+aczvasd0uTZmlerFNmblJLgFiGQ3Kw3KYNljwn3BLP24/OL?=
 =?us-ascii?Q?D3JlOfazecmevh6BVML9V8ZKfA9kvTVk0iaGeiA1Gcm35d5T+3LUGNYomm30?=
 =?us-ascii?Q?hBpT88nh36PjdKheV3r9llVtLvCd/4dunkPfvjYSPqisKzFLT1FH6sacErSN?=
 =?us-ascii?Q?RroDLGfSIjHr6GjEYm1AvavxsTwYTJCS64TfAGYt7svnYitEXiF7gXP8QFzR?=
 =?us-ascii?Q?R0rC3UeSSmLQJG3cK+4oAOTmzOrltM7WgZ+JIDf+D78kjw0SE+ejDgmkilmW?=
 =?us-ascii?Q?PrUVj1jENtn/SDzUDn3L8g90lglWhcBjkUA/k3IubAbaVGGKlsFzHi1OeYxY?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E353C41E7F26C4DA00856A7CB341E8A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /kWGEaSOJT4sx36owsRvnU02zYJkp+/s9fNRW8aFdjICumCDzpNR6wXMHtces6vLA1VQWZ8wP81nnTv/ESUtUzeLpHd51Iqq/lPqZtYiR97W6RiBIFMUlkPW+13wOMkE7FSdlJONtSLI6oHA/H6uaBv6capLsqh4MQAvqdfDB0rwo4zUAoP4WTANfy60C8rsShTj4uSKQG2ybW17mouVJPyKXRhGjmsgNyOEWRyX2gExTIWhOLndUv21HUUX4v7Gw67WF2z9qGJvDYgWQnaM3LJtMx493GYHdCxYEqXotbR52ICOX01Oh3qUW+FpAUGst6n2NKNIJd3fKUwqR0dYSCqQ9ImT8OtYSh8q0bFC7kjFuF19sSTe4pExbAuNNezWI/2VG5kb9SNb3DxiHOWcfyfw/kPvqmL7CtYBqHN9h5ElAhbZEpz+0m2stWr98MVL5BApz2TsV3cemAEeq2qalSsIH+Hcm9D4JfPTXhJgf9GXHbwjWl+UOI8Q5Oq8b1ANNPCxEjws539OQVuhdr4O9PdOUQ+CVhfZ9HYP7601noDuFTeIGqZycDv68dhMkCCQXLZYjJmVz0EdX7ZoG0qkJSdAQStolf8+6/k3ZrHTRF46uB9ULSUR/A7pakSThrhNycaWL5eSCB221RGPqQl59WXNzuOYIK9FJTHysFL4OFB4uWEgZkuUaJVNDKdP4AQfYLcTKfKvGZ/Mix48z8gg4Rc94MGOUJBY0fu2frZ9S5/IWHrIVfOLEL/5U+QznwTFMfrP3XDo5N1oj4EsheRpQzf35vVCIDvAjDZwqUnAf5I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c379399-31b1-4f86-9ede-08db7358570d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 19:39:05.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBqxuCBsubMzzXSZDTW/o78o5NjB/WHYIm9UE4Ik1Xi1JjcDRHLyo6zvqjfv2JnqKOMlLNS/c4lYeH0Nw2/4GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_14,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220168
X-Proofpoint-GUID: RmvXN9YkYqTQsyVUXjDMta3_xim_JBvr
X-Proofpoint-ORIG-GUID: RmvXN9YkYqTQsyVUXjDMta3_xim_JBvr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 22, 2023, at 3:23 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> Hello,
>=20
> On Thu, Jun 22, 2023 at 03:45:18PM +0000, Chuck Lever III wrote:
>> The good news:
>>=20
>> On stock 6.4-rc7:
>>=20
>> fio 8k [r=3D108k,w=3D46.9k IOPS]
>>=20
>> On the affinity-scopes-v2 branch (with no other tuning):
>>=20
>> fio 8k [r=3D130k,w=3D55.9k IOPS]
>=20
> Ah, okay, that's probably coming from per-cpu pwq. Didn't expect that to
> make that much difference but that's nice.

"cpu" and "smt" work equally well on this system.

"cache", "numa", and "system" work equally poorly.

I have HT disabled, and there's only one NUMA node, so
the difference here is plausible.


>> The bad news:
>>=20
>> pool->lock is still the hottest lock on the system during the test.
>>=20
>> I'll try some of the alternate scope settings this afternoon.
>=20
> Yeah, in your system, there's still gonna be one pool shared across all
> CPUs. SMT or CPU may behave better but it might make sense to add a way t=
o
> further segment the scope so that e.g. one can split a cache domain N-way=
s.

If there could be more than one pool to choose from, then these
WQs would not be hitting the same lock. Alternately, finding a
lockless way to queue the work on a pool would be a huge win.


--
Chuck Lever


