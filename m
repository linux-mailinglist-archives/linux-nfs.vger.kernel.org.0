Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233F86BFB2C
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Mar 2023 16:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCRPU4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Mar 2023 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCRPUx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Mar 2023 11:20:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085291BAEA
        for <linux-nfs@vger.kernel.org>; Sat, 18 Mar 2023 08:20:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32IElvwK011474;
        Sat, 18 Mar 2023 15:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=iLBN8gJ1dey4+mvzornbalOmN+mCZ0BSC8U26gi0YIU=;
 b=TPh9s79HurB6S40jLFggjsiHkr0zfrau9L7OsbTHmGDCHofq5nluvWV31B8vGuEvvKZ9
 6T43vMhQVhqAK2TJ+PrA8Z7pJfPYlKJsyw4u7lOoDh29nJKi/xsHJl2D3bapK9w0mjgB
 1AqjCiJJoXsAbhFQZ416u4DdOlD2e/yFgnLb9L7FtJ7QJgC6fVSJQkNSP8/lzo6PgdjO
 g/mVogGVQ3nb2XA8J0nYbHJuy4ZRcL8tYesb1rLeduIszpdtiVt6A2lNGrwU4CxNQrYv
 eB1WwfU+dxSRhTuToQzt10+dZ5t6hyMN9wE45bdPIHmsVWofatDVNib9FLStllzdqeQR RA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bc8qj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Mar 2023 15:20:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ID1CE3030304;
        Sat, 18 Mar 2023 15:20:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3ra0em3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Mar 2023 15:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIhhunrql5+9LPJO6giMnHimXQkRuSHjNQ7hSQ+bifEsejLju4NedNowbpfKVMO4h6jJLGrFjti8A/gAD4btT88LlqSZrqgoXAFiUqweXbJXqGQaAkldn6c+cXo0nlA7sztSOXYGgWfDS0mkovWzLIDg1NpwRR5V93+dFSDuo8xoOvmErFZnxIWDlUZ5lE9K3v/PEdgrlHpvd2dxDnnZsIgLD+xWexHa9qbxSfLfRFVhU7zaCp5uienpEF94htIYsBjkcAr7qXxXuKUYan5WgYePUpzIeYWZCkZ2Y+TuRAXAZNqCrdpoku6erCTwU1afq949juazQOtR3ySi9CMC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLBN8gJ1dey4+mvzornbalOmN+mCZ0BSC8U26gi0YIU=;
 b=nocrDZxfzpkgGQBm0j2hpURMQ3VmhIYzCAewZ3XpP1AK+kqhS/ROhgIdVLGfc9v2RCK1xioPoSIbOEQiYGrV7JIWri9wPnjFLzM/wYDDR8F4OEjt/ku4MzrjUWK0McBleZaFNSsGpCNzkuw1Q6mNfXdf1K9e9kuS0SgJFn01rF4xt13N7wB6D49lCt8NdFmBY091xqtXSHEeBcC1qnoZ71p2pamUs+Yy3AqOuDanXnJl8w5ksMYiYdgQbdoBI+VDRyGmTDbp3kpPjkztH7KkZKj7wrHf8YKW4KJM3MBZsSVtAlp4bsIAZo/VCtBbvEzofn03CSMkwW4wNxN1V2rgtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLBN8gJ1dey4+mvzornbalOmN+mCZ0BSC8U26gi0YIU=;
 b=qrngq9JwI+v1ixALLKv+pmcXYm/RixgHSLjonorlaqRtIinymBIjlJmxv+cTLpwemEPz3A7d6XAH6n8gG/oAvtWPia1R6/161taXMUgBN1H3OdgrzmiQ4nbPtOnneIvK/XH6TTYAIUStYRvpAzWnNJE+/G+hFT/t8jEx9QnxES0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5209.namprd10.prod.outlook.com (2603:10b6:610:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 15:20:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 15:20:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Subject: Re: [PATCH v1 0/3] rq_pages bounds checking
Thread-Topic: [PATCH v1 0/3] rq_pages bounds checking
Thread-Index: AQHZWSSVPN++Ads9h0qgGm1FjjxOzK8AT6OAgABYc4A=
Date:   Sat, 18 Mar 2023 15:20:36 +0000
Message-ID: <8356EDBD-7062-4F44-87F1-FF2BAE7F359F@oracle.com>
References: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
 <cf2ad1349a19b472653c500cc7e287843a0cb8c7.camel@kernel.org>
In-Reply-To: <cf2ad1349a19b472653c500cc7e287843a0cb8c7.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5209:EE_
x-ms-office365-filtering-correlation-id: 34a33d8b-eaf5-4217-954f-08db27c452f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coT7wqSLhkjvcKR7jn/CsNmrDzcSnkqMz71QaLVJE2+MziKY81NgoD+JudHikTfkKKcLlfitaWea6fiLimqDgAm3NSbnBNicHx1rv4D1kCVuH5EnkH5U/ra3pBeS7rH7g0RT8bOYxKpqd8zcwvE6s2IctsFe4HBraLOpNFG5BuTgycv/nbFCgEKnvXSnrcDmKxlBfOmJZss6w31hRC+enzGU9Ad/MpwXOzgVFQ6qVNEM0Eco+rfylck+Z6v4jUWBjPz05ZCtFwMUdSxpF7lXUw50Mlz29taORYqtcKlURGgmfKSdPfpgvcVoxpZDdzTyJACLWjSxjLFdQEjyugmW4gVVgS6R7CX/Ac5MUl0hQZ+Jr8YRKbxVKM/aF3QhU2kodyVZ68tclxHNztWH2FMwvVtcKlulOt14g5Vqa/XiCg9tJHf8Sgnf1ZYHBNpng1Phlkt0ZSJS6hwvhyC0TFQS1MJaTHaTc6nzKFic7wgqBpgO2tBvj2/E5JnaSl3yJEHcgXzT9yoP0CZTsQQ6MXqr78/FL9Fb6KFySSM1DP74occWcU3EuKQ8YwnRhsu93UnH0mW4Kl4mWJfyQAtDv1fYaaPYLtqcc1D3EzG0sloKIHBhRDLnpQqUt5NDa3QeiuGzcDQsirktwuXodwDDHDJgoApxZYnfsL99IGDI+vbUrUjrDNa2XgHjDN5ZvxsQ55eXJ+w+UAMKmxRo4JDTojWazr/7HMHAdajIfl5KT+2L0zE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199018)(83380400001)(2616005)(38100700002)(86362001)(38070700005)(122000001)(4326008)(6916009)(8676002)(36756003)(41300700001)(64756008)(66446008)(66476007)(66946007)(66556008)(91956017)(2906002)(76116006)(8936002)(5660300002)(26005)(186003)(33656002)(53546011)(6506007)(6512007)(478600001)(316002)(54906003)(6486002)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Of0NrJ1OkNwA8DWy1Yh3Q6G0VA+PBFVlDGcO1Ka9MlW0eynzGdZ6BP+7KKM?=
 =?us-ascii?Q?7BXIsdB6Nu3RxK3sJZuZ+jdboaEi7gOOqlVfyH3LQH+JXkYRHlroJSA/wMgZ?=
 =?us-ascii?Q?Bm1FsTMY9WwyoMth/UZqMBiacy7On2Q2x5RnLPCRXOKyJCcUse80l0w04aWI?=
 =?us-ascii?Q?KQyIt6MT4eBuvxAtxbhVw0U3VJsK+wWky6bObC24pniSIljvTgLBQf2V0HX7?=
 =?us-ascii?Q?bz41e0lPJCmOc6kL/66bntqipvXf8xEl4uSjVUzjmaG64FWWDfb/RSpu7mHT?=
 =?us-ascii?Q?NTEBcx9xvsePo4b9hKWs5mnMWhPzpXCH4eKiwk3RYLZXYJdFenxvsySVhLvF?=
 =?us-ascii?Q?sILBq+c0dT8/IbosVCIu+i+cr7KJm7Qe8m+ck/khfhDXhMVjF1Cf9fJ5Po0V?=
 =?us-ascii?Q?BPDHFQiokKriMMc2u1co0+r3Lnlb+Yyg0fwBc091yGD+lBqaA3t/qzZa1e2Y?=
 =?us-ascii?Q?eJYwLp6Sj7lkSKzYLQbeXSATBd/aI6XVFX25amgVIIHh8BIn3b0KIv/hQsqy?=
 =?us-ascii?Q?rA1T0NNW6C1KEooN1qvBw4ymhVmk5ydMa6I94g9bweF0pbNj9MX6q3WwBRIk?=
 =?us-ascii?Q?pLF3rIw7NSbrnitlp8XB41hSkFZP2QZF+pBz3IzG3XeAXqjTprygiM51lMtd?=
 =?us-ascii?Q?Jla2UBbu59y2j8vkef90/yB7DRKK03jlpw4N8AjC61djm1845WB8mhHkqEHB?=
 =?us-ascii?Q?KWbhPqlQrST3gXaOF8dBvVtOP3JOu9tg76q93mLWGTQKh/thKHRlw+0JMQGe?=
 =?us-ascii?Q?V+p51OiE68gm2i4rOUxtmoEIT8yU7pbhWzQCNmTM/iG9+HOiz2h1q8v3v9a3?=
 =?us-ascii?Q?d8HWQZDFQzbiBYnTEIs4QzxY/8ryBY/KSAuEp0GKd4bbAQdYKyWa8fSf4d/w?=
 =?us-ascii?Q?83RXBWleaZGTH41HlXfT+zwslM8kUPaQkYRtd1W0jyi8twJ5neQw8JKUgEL1?=
 =?us-ascii?Q?PM5B5xstuehk3RoBVsT0U4dsqbHdR2GQa5Rmrf5YZlpLx/IIhEeqrAlJjYKH?=
 =?us-ascii?Q?a+VF5FI2HE2Qr6BQer449R0r707+4cco/9kUoQKE41/5Z3E8kf6K+8Hfxg1Z?=
 =?us-ascii?Q?VPxV7TQNUZwxO+YgQmt4dgPAI5e5blSGxmY15Tivnz6aFqcLxuWlebuYiKAe?=
 =?us-ascii?Q?+d7jLzgKuJwTcWMkMqevFMnvBBOQnyJYDSryh9QQzvGBmvx+A1jtpYCSHaHC?=
 =?us-ascii?Q?59yKFNg3lguGtkUsrHnMaaFAUgFbSFm+Fc8bLh4mqk0fgHzsW4BP78aAaaUe?=
 =?us-ascii?Q?ix0kiK8zZtgNVz1oslhd8IH2eDkllfPBW0R/byQYBKzYe6sHCET7p7bslJfD?=
 =?us-ascii?Q?/0FBqnMnHeMzTr7eEpMHia4N9kgcXFEytXArQYB4UplAvvu6mNkzbZOtmZzB?=
 =?us-ascii?Q?rA2HFUXO2bEgC5yIgku2kYTHDo4kiirghpVAfn5GuXPA2RossPXK0HZiXqjR?=
 =?us-ascii?Q?WoL87oBA3xo+3i6Vc4qOtRMaKb+FQFn8MCl5JExHx0SaLxMrGSIDsN0jAU2i?=
 =?us-ascii?Q?JtC/ra499WJ2S2mG2mKcwnG9Fi13uufIloNvxcLh1phiCugjANBkz+5Bpe62?=
 =?us-ascii?Q?UutgmBWPlfy2UAskKj4xjhYLy2fWLsLvVq11BER433NxdzU7MRwFzCh0A8hc?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1AFF46BD43E37D45A57CF2DC3A064C24@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pM1kzzvKPdArSZWAi/4BtYDOkNIFrn1ar6rBVWvS0NsGLCx1gZr80mA+r7V26pfH8pH5LSIIorp2t1RfP+svfcYcX5eZ6NK3uPE7Euaxfn1LyhgNdmJ1g9HxtFBE7M+GRtXhPecERNFLUKRtXbxUYDaEnIye1kE3huofeWqqQOkDifSU+IgEYmoTTK7U3gG466oajCUrNrmLBc0rx/Aqn9UB25RuM5OvxJIZZkzFxv/mwDzVrD65aa5Io0JeXcE+V7goEq9JvbGKfX1cvxDwQgJ4YsOlkID4R8UBPTDxVpiXpV9n2KA25TBLE882TJjh+TkcwSwWhRGFLtCe4pfwrvV3V0K7oP+hs3N05lBXnfYQ5dbbgEUdLhytIXnTvW8oh5k3ChJbDau+oAr+/sEqRX7/+4YFMrZdhkxqZuVVeKMxzxzPOKUc0ghRnwn6IvpO3uBK1GkemCu28pIH/L9AxE1alRfm2SnN/pF3n1C4LTOVVclObdusFCHZrWp5P0w8Iu3qg6u4vsre51p2+j6D+xQWZ9x+1JXKLo+3YJ4OlAL8nDQXsXpXSovVr849qkXArWEB9X4lghFXgng00wqnexONU1EFf7QNIH2e/qb70bURhyZQoXHnIVdFrr2Uj2vntcORVnbOz05bgCHt4qbFiGqsFl2RAt3FplILg52YUihX7y2n3tKGOuoKqDKfsi/Ak+GiUKkMvHXCyz40GD58C9HsPSMXiKfAOdRnKJaIg1C38DQskfQvZGOkmL0rbSA/VcFDS2f045XaFbTgVpXDU6EMjLBBFxQTT/mSKULx4YhqinkJiDKHXGRtauDBuppj14ZMUmlJTMyT5qn1ri7nRFaLSK4wEn7YjlxQ9jAgokmbis9HN+IX55pqM1Ym9XC9Zwj2vNK47fvjPzuyZolPFQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a33d8b-eaf5-4217-954f-08db27c452f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2023 15:20:36.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sbpv4o8bAUvPIOAvJVLkibhABWNmv7zzlbSre5tLlqJiqfa7kAqhFCYNK3BuUAyDhRooXf64geqOOWmFaqWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-18_09,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=944 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303180133
X-Proofpoint-ORIG-GUID: moW1qzE7-ZCOheFsiE2W4D34pON9a3WX
X-Proofpoint-GUID: moW1qzE7-ZCOheFsiE2W4D34pON9a3WX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 18, 2023, at 6:04 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-03-17 at 19:01 -0400, Chuck Lever wrote:
>> A slightly modified take on Jeff's earlier patches, tested with
>> both NFSv3 and NFSv4.1 via simple fault injection in
>> svc_rqst_replace_page().
>>=20
>> In general I'm in favor of more rq_pages bounds checking by
>> replacing direct modification of the rq_respages and rq_next_page
>> fields with accessor functions.
>>=20
>> ---
>>=20
>> Chuck Lever (2):
>>      SUNRPC: add bounds checking to svc_rqst_replace_page
>>      NFSD: Watch for rq_pages bounds checking errors in nfsd_splice_acto=
r()
>>=20
>> Jeff Layton (1):
>>      nfsd: don't replace page in rq_pages if it's a continuation of last=
 page
>>=20
>>=20
>> fs/nfsd/vfs.c                 | 15 +++++++++++++--
>> include/linux/sunrpc/svc.h    |  2 +-
>> include/trace/events/sunrpc.h | 25 +++++++++++++++++++++++++
>> net/sunrpc/svc.c              | 15 ++++++++++++++-
>> 4 files changed, 53 insertions(+), 4 deletions(-)
>>=20
>> --
>> Chuck Lever
>>=20
>=20
> Looks good, Chuck, thanks. You can add this to the last two:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Excellent, thanks!

When I started I expected 3/3 to be more substantial, but since it's
just a handful of lines and the patch descriptions are about the same,
I'm going to squash 2/3 and 3/3 together.

Only question is whether to apply that to nfsd-next or nfsd-fixes.
Since it's a defensive change, I was thinking nfsd-next. Let me know
if you think it should get merged sooner.


--
Chuck Lever


