Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E9234663C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 18:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCWRZd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 13:25:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40228 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCWRZH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 13:25:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NHKI8J144746;
        Tue, 23 Mar 2021 17:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gNDdIQIklOf5Zotf/adXzzcCozOr7S8VWLN8SAtsAlc=;
 b=Wq7PeBIJl2HHZqZ0lkbg1fQwJQI1ssA2J6gAvLucFHCKRP5hK2Oa4kawwDUx55L9cO3+
 Dhga3CqLzBbwOnu1oH5r055B/DNsN/a5T9Jshs9AmKUQl2Vfz6R3DLTM6hv8tBjXJ03s
 Wi3ghyl4nq7UBmfG/y9mKWmMj4QfcQCdPylvdZ2gkEHeDLYcbwx444ETrg4Pm3wxJuFp
 sLUNkt4WxEhkvpqsY9hvQKSBFbxDDD8fNJlnUJB8OpDvP4wEYSbTvlne8zJIdgXzzM2U
 VlHzhrlVNUEtENTIfQEr1NIjAKOYlcVOSW5jl/bVBvttgj4WLEF4668Ol8q7sPPG+blg KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbg2q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 17:24:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NHKkf6089010;
        Tue, 23 Mar 2021 17:24:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 37dtyxr8v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 17:24:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFP2N0Mkp3WGRg6EmqN/UhD6JZxiTSm8vc4MDK+2yhNvz3AeV5ZRSqs51c37vLhmbn7AvPkPbB+f7lBjuz8Z+z0z6xAssjQmnk23Q+Ka4w+ygXmTG43KjkoDVoQaO6DRMXKCXsCUDuk3qiCj5OrLtGzjjfgL25PjIBQnDn+HeAahBjO8u47fGRb2Olmb3h9Vc1g8j6rl5+smBAh+UVbvhapQ/Y33XPcw/yKHAHxYGfCoid7AJGWFj84gRrG7mjWu52AVWuO+WM2VS84rWByVfFTpHTa0Kj9TnjmlPQJpHQmlsa/f47Ntre1ZvgtM8Ot6yyvHwQ/tlvVP9TPiacFXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNDdIQIklOf5Zotf/adXzzcCozOr7S8VWLN8SAtsAlc=;
 b=C185MRKqoVz7PCouFWJnDjCvlNEgJw7P5UZXlCs0G4jJifLT4ZI2D1F7Mt81x5MMk95JhXZeD4QDgxdvduRXfgRJLeFTV4m+AR3lajyuhCxIHd/xxaYyzl+RTewgI9sQBHC202e9yG0iDlFWC1z6PFWQGlFNlRES1RaJfZyuIMrDHdkcWeP9YmEG2MeEdgMemI2IDKkN/NRROaL1fk6oMzRoSnCn3hNbj8nT/6R1yWY9CZUQVvfEBH8g5woDLPetZbhFa1W2tJGpjW7smhnO2YH7H7AtbxOwgpvRXkBGNByPkWz+Uv2RTLD5XHE7ySYg+ltX7YVMWKe2cRoiAFaG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNDdIQIklOf5Zotf/adXzzcCozOr7S8VWLN8SAtsAlc=;
 b=uQstYh5el7CiIt9wUyy+cUj0+Z7CDNyjhKPGArAMGl4A3CZgfv9z2GIQW6BbQgOUDSv1C0oHl9vDQSgUhfk3Ycxe6FoXEAuZrOkvsjF/uhEcJVq7ok7LEF/98eA0lFGQM8yFK1NdZRX37xNSzMH8GqQpf/+3+qvFIRTOh1H7PP0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4275.namprd10.prod.outlook.com (2603:10b6:a03:210::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 17:24:56 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 17:24:56 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Topic: [PATCH 0/5] nfs: Add mount option for forcing RPC requests for
 one file over one connection
Thread-Index: Adcfp3hcmhRvn3IHQv25MQlIHJPMUAARGOoAAAMHR+AAAek9AAAAU0WQAAIhaYA=
Date:   Tue, 23 Mar 2021 17:24:56 +0000
Message-ID: <575FF32B-463E-41D8-882F-6A746DF7FDFA@oracle.com>
References: <SG2P153MB0361E2D69F8AD8AFBF9E7CD89E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CD47CE3E-0C07-4019-94AF-5474D531B12D@oracle.com>
 <SG2P153MB0361BCD6D1F8F86E0648E3EB9E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <5B030422-09B7-470D-9C7A-18C666F5817D@oracle.com>
 <SG2P153MB0361DC1EF8EDD02356D29E579E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0361DC1EF8EDD02356D29E579E649@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d73b1b48-7eb3-4fe3-23fd-08d8ee209413
x-ms-traffictypediagnostic: BY5PR10MB4275:
x-microsoft-antispam-prvs: <BY5PR10MB4275F39A3C57326D150DE88D93649@BY5PR10MB4275.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGBHpV5UYLQDmeKKvyDA5fEoF+dlGH90Z9XgNAP3K2uwXLDJCvXIDvvqHuQMRhnuALhl8kOWu01yPjNIS9OuoU+7rmfpo0bvmAs1gm/nlUWlzU4+WKk5B3r77GpRnaUHlSwmLLAdF/xLMt9nfadw7jHESnagMOmO/gmAm8Oq1/wn+japKicLE/YYvbB35+WpwDhw6+5rcWjBUdR7DNg3odmM7/ho5ZY9YvLeQ8Jrz4K15pQRgyglmr7ecvH2QsJWWpjv/lxRoU8H1MGHCZENNSutIIYjp6RBdvs2zcC3Nop7p5XeSI0eMoETCn+x1mjgjXGIovSFcdloOIDvDMhy/0K4wKNDDtvHWmK1XnRzpLLRHaf5flXOcdPAvnLokx3yA/2vVChuX8qK6e6t8i2Yjbk3juq0DzyOFkmUIMLj1J0rmWkG5CAPWFxZHowK9pgZR24IsodXi8VrS2wvaDe3KQIjNzWcEQB7uBugZeDxznAypYy/8uO0Z3HXaVNFxQ1RKbZKe9ZB7yBcy1TvWGbLa4s8QTv3C2EANp5F9kpLWUwoXLPmB/yxo5XFc7uJSpYwID0cG8OhQwJm6cYTUtaAZsNPKqdvW3dYNhURc/88qeoe4ziktGFu5UewwCbBrG2TS0xCVbP90zu9ig85MXreOprXxR6g0knWv5MaooAjE+PNRt5xn4UixF8Lf8gkaWD9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(136003)(39860400002)(66946007)(6506007)(91956017)(36756003)(76116006)(316002)(66476007)(4326008)(66556008)(64756008)(38100700001)(66446008)(6486002)(53546011)(186003)(478600001)(86362001)(26005)(8936002)(8676002)(71200400001)(33656002)(6916009)(2616005)(5660300002)(83380400001)(54906003)(2906002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ddfsADD24qo+CeGyDL07kO5HFH64hMXnK/SrDtF8bhpfVZEKe67pj7M9RLqp?=
 =?us-ascii?Q?j0P1tsypigQy92TcXbGA42yOc6UszbU4foqSkEXZsnjcqOm/6y7BW1Ts7wy2?=
 =?us-ascii?Q?0zWFujtAUF4aapCacmmC9iI6HsoPylp7z5rzmhrepfb/kK/ukSCnCGQZSo6Z?=
 =?us-ascii?Q?f3xp8ioWX+B8ZVdXFOVvD7By89KXGqCuOglGjzhhfBaSYWmN74ZZodK+1nwE?=
 =?us-ascii?Q?GxryHONU3jYfItcAz0BRiDQ9rF3gkzxoXcLeSrmYxwryoIwLP0+EoJS+wz8C?=
 =?us-ascii?Q?KuY8NuR/h+rGudlaxa9cNECq7XdM0TA8TQl1coHCafQzpzrRBUUPHYIT+FAK?=
 =?us-ascii?Q?nkd2/wQ4Mk125jvtJStpnZC41f1T+yLIeStpedK7mpKP9KxhWl4SWrdXt6sY?=
 =?us-ascii?Q?16q3ZjVChEndHZchdYNcI7EnsS4vbAnKD1xe6TgqWcMeZyt4c+g+VYq7K5cs?=
 =?us-ascii?Q?DYij8cLCy7WeVY2s/u0XeG9XjX5OBSIF/7JLKWY/mKzwBiJfudpPrvrG/SmY?=
 =?us-ascii?Q?xLfMAb9saHglmD4mjmDNroy3fiaN/8pqiOimx9N38a7CGjnXy6IJyN5yQYXE?=
 =?us-ascii?Q?9D0hEQjZjbDW4+VuSyPdKJ6ZIHEYsWE7+ZVupaB2MNyPZx4wNBQRh172n8KM?=
 =?us-ascii?Q?eugsdv6NXUmbLt4Ole29asCRbpHYYShrIArRDkBDMWDQFRgWmNxH+nkg0K7I?=
 =?us-ascii?Q?MZJNNpQ+cYlTlrdGE72Ojqal8q2VNEBn9Lj43Gth1pt0H5vEsKUmYnCSdxWp?=
 =?us-ascii?Q?65uqqwrIYXpNpRM4F07oepEg3DNtbt+dAb6X51w2ss4IHUN2BUfmRcGSA4Xs?=
 =?us-ascii?Q?FJ492oXZGVl341IscbFkVEB7QsB7k05RvTCdatW11sihJOIUm05BU1Dpj3Ae?=
 =?us-ascii?Q?nY5ti0tusuJYDOVIDfQuaNyLGUDvlMIAtFdDfYJug7ePebepdn+3nRXu8QRy?=
 =?us-ascii?Q?tI9CpuvkqIL+i47ZE/bcG3QBi/wjLZrbjqFLo3eWsyXNXgh0zBKKVRQDuvHj?=
 =?us-ascii?Q?RwaATJK4DaMTNrW571gKVNmpZIx7JZ3Jz2eMuCjsk/9hC+byUCdw8tjNAxJa?=
 =?us-ascii?Q?Kc/iP7moUuJEZmuK1ci7xgdhrJ0J/F4+dm1HW+4J8id9hbMjVMm8fgqaeeaX?=
 =?us-ascii?Q?4tmqbNXjjs+QT5K5medrDWfREx2h5cYbz08b4pdhpMN03ulIo1V7QqCyi4ca?=
 =?us-ascii?Q?E43/j/SDjAul+hP/arqDqMl3rWaxmbNE5To/jfRgvGGfGeh/LGBVl9mdXRRc?=
 =?us-ascii?Q?nI9y9+KuZnHf1CCQWHApVUDSj1st/Enwn4eNEmQ4R/3q2YuHfXKXPdiVfPuc?=
 =?us-ascii?Q?67xxmfoObZ1VDcvftLhCuzKZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C34BE482172144B87D2BF6F721C6D72@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73b1b48-7eb3-4fe3-23fd-08d8ee209413
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 17:24:56.2546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JBIaK/9bARrflTniFYxLMIFyvSy5T6DxH7BqFKmTeRjxSJK3xoY1MICR3Xrsx3l4I5jBmrjrtFS13sinc5Dzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4275
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230128
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 23, 2021, at 12:29 PM, Nagendra Tomar <Nagendra.Tomar@microsoft.co=
m> wrote:
>=20
>>> On Mar 23, 2021, at 11:57 AM, Nagendra Tomar
>> <Nagendra.Tomar@microsoft.com> wrote:
>>>=20
>>>>> On Mar 23, 2021, at 1:46 AM, Nagendra Tomar
>>>> <Nagendra.Tomar@microsoft.com> wrote:
>>>>>=20
>>>>> From: Nagendra S Tomar <natomar@microsoft.com>
>>>>=20
>>>> The flexfiles layout can handle an NFSv4.1 client and NFSv3 data
>>>> servers. In fact it was designed for exactly this kind of mix of
>>>> NFS versions.
>>>>=20
>>>> No client code change will be necessary -- there are a lot more
>>>> clients than servers. The MDS can be made to work smartly in
>>>> concert with the load balancer, over time; or it can adopt other
>>>> clever strategies.
>>>>=20
>>>> IMHO pNFS is the better long-term strategy here.
>>>=20
>>> The fundamental difference here is that the clustered NFSv3 server
>>> is available over a single virtual IP, so IIUC even if we were to use
>>> NFSv41 with flexfiles layout, all it can handover to the client is that=
 single
>>> (load-balanced) virtual IP and now when the clients do connect to the
>>> NFSv3 DS we still have the same issue. Am I understanding you right?
>>> Can you pls elaborate what you mean by "MDS can be made to work
>>> smartly in concert with the load balancer"?
>>=20
>> I had thought there were multiple NFSv3 server targets in play.
>>=20
>> If the load balancer is making them look like a single IP address,
>> then take it out of the equation: expose all the NFSv3 servers to
>> the clients and let the MDS direct operations to each data server.
>>=20
>> AIUI this is the approach (without the use of NFSv3) taken by
>> NetApp next generation clusters.
>=20
> Yeah, if could have clients access all the NFSv3 servers then I agree, pN=
FS=20
> would be a viable option. Unfortunately that's not an option in this case=
. The=20
> cluster has 100's of nodes and it's not an on-prem server, but a cloud se=
rvice,
> so the simplicity of the single LB VIP is critical.

The clients mount only the MDS. The MDS provides the DS addresses, they are
not exposed to client administrators. If the MDS adopts the load balancer's=
 IP
address, then the clients would simply mount that same server address using
NFSv4.1.

The other alternative is to make the load balancer sniff the FH from each
NFS request and direct it to a consistent NFSv3 DS. I still prefer that
over adding a very special-case mount option to the Linux client. Again,
you'd be deploying a code change in one place, under your control, instead
of on 100's of clients.


--
Chuck Lever



