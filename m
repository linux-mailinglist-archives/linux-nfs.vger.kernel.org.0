Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9A576A71
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Jul 2022 01:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiGOXMt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 19:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiGOXMs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 19:12:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2D75B7BC;
        Fri, 15 Jul 2022 16:12:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKYfkJ022288;
        Fri, 15 Jul 2022 23:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ASjqUqNlnNY+JZigRc7SqITDekaX+XKEkKgvJBbqEC4=;
 b=tRAEHJ8ESDBngyifZ/4/ll9gDmHcR+1MXx7e0honx8/g02eVrG/fx5a/y5yXbT/PlAXh
 b/RWSBLKiG4RfklWdAHl3H3QKp7BxxjSEe8e4pSuKYpaRxI5v259kz87vmlmwY9m6UBD
 k86+ZHzVo3ZUX3p4jChlOoeQfKnG3YIVb9C8xF5uy2+8qlEj5sll058hBuWJVhfXfXpN
 3/T3QJU9XXswkxrLyAI48ei80Ldcuvj2qmZ2Z3GlN0qkZejnymC0Hdhl/B3xAPyVx04N
 Ij3mkWh3EDZuLTdOH0JksdXE0yRvroH3A7fFIQQlyB/XIJokHhQ3SbcwOGm6hu1aThLG KA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71schagp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 23:12:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FMok8X012948;
        Fri, 15 Jul 2022 23:12:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70479unp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 23:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8mR7nP+zvdT1QM2i0ievK66y9ufSVp66n9NIhLNCfyPx39C9fBCy2gW33517FBLonWQzahO6PGD//8Y/n2EC8QZ5/0ylh+4RJ76oS5W7/pnry6fu3hseRLR4zSnlFb6I8WxLV9otbfxX0PNhO66lidOa4dNNyfdvNZiV3FCqIb8gCT5ED7PtG4XmHzhWnT82a1c6pH1teTaERdabG/x/k3Ff9BCUnEOMNWXShNF2eqD89sYrb4ZObA43xGfrTNJA4Q4eYZUKwFP8fd+B7ILAPmwdX29qZ0V051BJQHc3roU4aJY/JySf1BM9Rt1k0A4XShAk682jKxGE8AIM86eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASjqUqNlnNY+JZigRc7SqITDekaX+XKEkKgvJBbqEC4=;
 b=DchED+IkataEDUarLt+v8wfC9IBOK4sCN7SDssfIw9IC1BeBg15TBt6NEUYmyibd/m0tw1Q4stlrCcUqBbBQF+7cT+X0tGglkry7EMWf+6YxnYDMBzK9lAoQZthsLf/z3c8s9h2I58ovf3EdpzkCWDzt9Gtv9pz7IgrqAo2Hxy8kVmFRP52VSKTcqt3ujHWQxJgyPOh9B3rQy34XRNVchG0ihb6tLpqlj39Tfo45t3ugep4z/pdS9+wJtthgAM+mNJ7DAgtXKCB4EsqA+FHl8bTqipCMgrHr7z+oIkC+Jf91jG1B4CNCgYOXuwZTQJpTBKzrbCLiyUFY6HpV0swK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASjqUqNlnNY+JZigRc7SqITDekaX+XKEkKgvJBbqEC4=;
 b=OtQmljAoHVGZ/lIHHPZ2sUouK2r1ysy10RmBnEs8OK9Gf0BQUjRW2uc8rCjrovtrBSUDXpmsRtrSbDrVdeMD2j526SRfncT6gGrADuIZUcT/JdrxF6a6L5xAllm3DzcySJG5idN0JlZYiiljDJWQbZJQ0Me4qq1naifWrSsjris=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB6351.namprd10.prod.outlook.com (2603:10b6:a03:479::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 23:12:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.019; Fri, 15 Jul 2022
 23:12:34 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: build failure of next-20220715 due to undeclared identifier
 'NFS4_CLIENTS_PER_GB'
Thread-Topic: build failure of next-20220715 due to undeclared identifier
 'NFS4_CLIENTS_PER_GB'
Thread-Index: AQHYmJ75ENSPDPYdiEOVoj+XgQHl3K2AD30A
Date:   Fri, 15 Jul 2022 23:12:34 +0000
Message-ID: <77B1170A-348D-447F-BA2E-E7025F662E2B@oracle.com>
References: <YtHyA8TL8ObXJ6EQ@debian>
In-Reply-To: <YtHyA8TL8ObXJ6EQ@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60aa8137-e266-4108-b12f-08da66b78088
x-ms-traffictypediagnostic: SJ0PR10MB6351:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taqV67tTIcrURvucjrx15Tfmeo0Cw029VoDaRpC+rEQoi39chQIL5JXvLorjFjYvLCY73yMnFz19SzdNwNM/LUjTRNlsLmuKunMhzpKs3vJti4K5nIeHNud/9R7OVYSxdmkGFU/IUtsRF5sFRoUszQiuf4ZKPxh/Z0Y+N0hkwB8iX5kXQkLb+2rlT5tC9fAQiQeduygWLX5i3IjBzae7suFnET/jtesjOpHfT8qFYhGB00I4RwbD4pRt2I70pqc+MMXVubqPsdeOAIKlj6Z9ZFDHE4jnjGsyT16ANHcwf60AmsJqWVEvlJMgnzxmYf+kp3OHsHWV0CWDqdjL/Ur5YcYaOe0TEW6/gq1g3pJfXdoXf1yj7sftEXiVIXZv0jZMUw8xQa4m+OS/5c0RbAxRPVm1P5P4Wiw91oklIuRpeg8gUmgIloZp2Pi2YkqkJfMPLnsREbhKNlRDTEJGpTzv+ppKcab8dHGMtRaFbSWv5SxWFdNZJJKxViLHrbL31OKoy9tPssjGGoE8xejrDgBkkqBGCsuLbckvtSw247NdsQmQ8ZJV+S+qsq6BrdeOazAh41ET40f3ZZl5VbCfmi1C5XiesmXhmthJSLmd3nKC+xAj7qhW1HPR6680ncS2gEBjsY6mRs5ekljZReoFyPTgwhpyTAqm+rsxvJDgU2QsIk0doN/ChJb8a+8/dA9lW0EQ46OYoAXsEjxYaWVqyZrqlL0K7WsV69SNTSG4VnDCc74fQMS0FV1ydfF2A8iyw8ux8/CNZUCuiPC6MC8wbYLAnucKw7K8/RJkdqB+kdmS7KBzfkKgQrcB7Uw/BT29Zxj6mG+4yaOaV0mbiXb5rPpabquDqqmZLYnqkFdxkPjcZY4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(366004)(136003)(346002)(478600001)(41300700001)(6486002)(2616005)(6506007)(66446008)(91956017)(53546011)(6512007)(186003)(26005)(38070700005)(122000001)(71200400001)(33656002)(4744005)(2906002)(38100700002)(66556008)(8936002)(36756003)(5660300002)(66476007)(66946007)(54906003)(316002)(6916009)(4326008)(86362001)(76116006)(64756008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Imo5FRJirKrQH+zgkCwAZ0YBj0+g0PZh7ubUQ2KSX64w4mIdhryCr7LAzZo+?=
 =?us-ascii?Q?KGuj9pzg8GOREL2Mxr9P3HSuXhXLhJR4dWFwIjS59c+P5ed/uAtVT+pTRkgU?=
 =?us-ascii?Q?zuNjd8lVB9X3Epmj+4BBCnigNWKnX+tHMmDt82PxyjukqkWXhNrNrD5YJH9f?=
 =?us-ascii?Q?vGD9B8DC6WbGGtB5g1lo6LDgHiGNnI2uUziS0mO+8+Se3tjyIXzBJbC3oG/a?=
 =?us-ascii?Q?mrPGSZZnMRc78+km+fb9HvTKOFjmXdFId/Ic6KpEtH5ByscbyE9VfpeF3cHi?=
 =?us-ascii?Q?5cCMVdhXmPeSpbapLWpiZ3pqmXf6GyzoRMBwvqarIucncFMhI2EYRQutMa2c?=
 =?us-ascii?Q?kqdO/YlAZNm6CTMKTnu8yVLBHbd1JCiG89Ge3PojRpLEpfX4hpmiiwxdsvwR?=
 =?us-ascii?Q?Vl6gYUmsuLRc0BKLNZ+FYgxo8aQwoJG1N/tXrWYj/Cw30ZsG2P13NxQEVkT2?=
 =?us-ascii?Q?V9AelpvdlAsLviIGwt+RohQ6ZzzCLpJKsP7SsxJyZTZ+C4ahGqIw5DwH/wTZ?=
 =?us-ascii?Q?/zO5Q1nLyD3qDrYC7HQTHhnUFfzaXFi/ULyRk/1AiGuaBDJVAiULq5yFfc0j?=
 =?us-ascii?Q?XcCaOojGiA+HMOGlI5U/s3UJ64+RJPcRFkPfyo4yyVmwz3Yk0TtjGPcOoxLW?=
 =?us-ascii?Q?ITRue/i1/lvwIuUe/u61798WmCOmTwZGeuFxKRo9xy8V66vG67BWjlrTjb+5?=
 =?us-ascii?Q?TRGk4Bunq4oCkV8RSCHBNYrHTtaUC0fhFRtbGNFazYyFQ4kHg8R/u0ZFp3AF?=
 =?us-ascii?Q?vFiJZkwFTheIU/8nuKNcoPL8xYhNFmdgQk+EvK6nRUx1rvdaCTcQXZlxYNC9?=
 =?us-ascii?Q?x0lsq4sbadkIFvIL/CWncKxvCJJDcL3UWYX9IJZ6tH0uI+2V2L2LYfJqy6TV?=
 =?us-ascii?Q?j1ME8mLFieK8fEQpUr36SrLK3XhbBwPYEpwcZVenx7jSFlZD1GDVI/FbUveP?=
 =?us-ascii?Q?+zriTK0u/ofwL44gRKC4mt6g3EIrBiLLNkTUcVvKlXFILocOOBtV0FDpyuWU?=
 =?us-ascii?Q?RMi9OHZuqWloT5Mq1JpAQ2Hqu8vaeHnub9V/X3+5WWI+zj/Cu3JClnX4zLH2?=
 =?us-ascii?Q?vKxOVE/TSx8J/4Jw7FRydPnk1aIhRY+oK4k6SeV7OkL3Yn9mkJ7WgwkEG7og?=
 =?us-ascii?Q?8+htTLXhhYz+ILstMyC6qLB5ORG3T6yxoTNpWTJpD7Frs51hlDbjuh75zPnS?=
 =?us-ascii?Q?PoRU/eMm/U0qRoTJ7FO3Re6hu9kfuB7iTRVV0uXCqrEdSxjJ0ZeTL6SwA39p?=
 =?us-ascii?Q?YMJagKecg05F6HdctiPgCwQolQ3OzsXjPlQexcEKrNUpkyA1KRf/Ejh+3Ozy?=
 =?us-ascii?Q?3MTRSI/dFi0s7uD5ISqjQ097WKS2VbqG2g0NoVTvJ+UPzw0vbGrrUF/Ep+aO?=
 =?us-ascii?Q?kvGCc7P3rJCG95OcQgQ58y2IOoPwqzzA7u5lmOKi6ZeKRyMFB1bgYCVrgPDl?=
 =?us-ascii?Q?kXuUdoRehwd2JYweYI+Plu7k/wm/vyYkTWqky/nqMlauJoO863KRkhgMt84T?=
 =?us-ascii?Q?1NHEk86uYHo5u/OSJvMXFaG2TBcRYeVH4Y5x8DshCrCBKgffrpN7/uz5nxbh?=
 =?us-ascii?Q?J0HEYMXdZWa9xFjG11kRD+wsNWabdKzLNSDW4Se/tbv1eIwWj6jJebyseFzo?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F50C0A0F88AFB418BD71F361DA21857@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aa8137-e266-4108-b12f-08da66b78088
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 23:12:34.7680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7P3KQrIEd2+PDsL8LNQUtsy/+kuv4GZJ2M9VSvMQ9Gs7IN0t45zu4Y5jVBJX+zt3JBngER8bGbeI/hAQeXfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6351
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_13:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=640 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150101
X-Proofpoint-GUID: AZC6rEZS8VLtq-FKbZp3KbRzh68KZDkp
X-Proofpoint-ORIG-GUID: AZC6rEZS8VLtq-FKbZp3KbRzh68KZDkp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 15, 2022, at 7:02 PM, Sudip Mukherjee (Codethink) <sudipm.mukherje=
e@gmail.com> wrote:
>=20
> Hi All,
>=20
> Not sure if it has been reported, multiple configs of arm and mips have
> failed to build next-20220715 with the error:
>=20
> fs/nfsd/nfsctl.c:1504:17: error: use of undeclared identifier 'NFS4_CLIEN=
TS_PER_GB'
>        max_clients *=3D NFS4_CLIENTS_PER_GB;
>                       ^
> fs/nfsd/nfsctl.c:1505:49: error: use of undeclared identifier 'NFS4_CLIEN=
TS_PER_GB'
>        nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_=
GB);
>                                                       ^
> fs/nfsd/nfsctl.c:1505:49: error: use of undeclared identifier 'NFS4_CLIEN=
TS_PER_GB'

This has been reported and the offending commits have been removed from
the NFSD for-next branch. Dai intends to provide replacements which do
not suffer from this issue.


--
Chuck Lever



