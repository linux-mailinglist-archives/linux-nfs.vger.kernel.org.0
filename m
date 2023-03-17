Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBF6BF02C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCQRwR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 13:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCQRwQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 13:52:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892883E1DF
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 10:52:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HHlKun019804;
        Fri, 17 Mar 2023 17:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=R25pAkzmq8e2G0kN9fb56VohMEkpfnBT9SOxiEu5ldA=;
 b=CI/7MZ2VaJ7cY8nZvBykNC7cQhOnccF1e5AfkhLGI5hYy5QmbgR9FY9IbneRqy/MGkfb
 hd3W507zZGemkP9BUn8+aWz3SPoXksjsXk+hHivUKo9a3O/D+ip2uZ7Ph6C/KB6Jpn+H
 U6LqJaeT+M2VaNy1EJwPsOjZxiqS0OW5AHV08gBuoKF2n5d7HX3KkK9VqR/6CqVHyEgd
 ORg14FLFpzw8tvTS9NI3UNEahoXHuQEBZ6MsU1NaMYQ3PR8/sQEJYBg6+tyJN5XseZEk
 6y19kvBhAC91lUWHlxuAU7On/I0ctvM0BOT0K4kECyLKUV5dubljs1pO1/Nc+nTQZ15q Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs294bsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 17:51:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHER02015712;
        Fri, 17 Mar 2023 17:51:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pch3xtqd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 17:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBpbZHeDpMA028qzvUKA/2HsECvbTT207z0UuTFIT52nITHbvfz1jxQ7nyPMTi0cm79bHezvhR/RR0BIAm5MkM7Vc+jXr8WKJKTPEizmCYJWqLwLwYO+Dn653UD405qRJreMy5jXZ/ty5uIt3cziz9GFspVBwwHbA+JI2BbzGOHrLzwwlJZ0ly8PdD7NBQYCXbh2IhVo4hvMs1c6JqCZfeYB8v/JCzOewnqgvknLSNYYHTOHsEbxd/k55QjTXI2Ao+sU5GDsLmpCmW1hpk9K8ZQ2S9bsh3hFm4f2Y6sJknq930JxFq2d+kHxlTBIeTMJEkpPIhByrzsttsgXfJ+R7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R25pAkzmq8e2G0kN9fb56VohMEkpfnBT9SOxiEu5ldA=;
 b=DtgRfEmTCLITvbBkWaD+/oIQkm6QwLG5InncrqTqL5MYiL8Umm/DjFQGGoXq35pcyXUb/Emlrabns+yMw6e/VLAoOTMTXeXhAKftEh9dP+YC8UyIPpqXLHLTSg9veuOG6ds+QRQMU341KbapbK241Zh+FlHyPTLb7pOkMt0GjtMkU8CCXGwT0ZQtuaj+8JMCLvtqtPScGkeg+A0OXz4KHKJuBuDGlsDlKrq8BcqI6VXZdztopfx9qz6uhBBgopOu2UwXMLfG0F3QbBREHn2VLgWdmaDGLxn7o5FD7Rbdf7yRL0VSK3To6GfJ03kTJTbEcf6LVONPGaySaQ7IDLB9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R25pAkzmq8e2G0kN9fb56VohMEkpfnBT9SOxiEu5ldA=;
 b=k0fMEPfyEb39BluemOmkWZB0reVrScUZPw+mX6EGBTCxkZHOh5zdkVmShhE+y7Z0ON6AJ2l3dFUhdxnbjYAWJ/likJe3kpghguvMBCv/JD8WpU1mKFbJ+NZzLiuA5fIGUk+cQpIARMfB3Iczz/M/KhxuiTeUftf+1IB15B/+MCA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 17:51:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 17:51:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
Thread-Topic: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
Thread-Index: AQHZWPPHhxprfvZio0CVZD7mRL0pxa7/QGmA
Date:   Fri, 17 Mar 2023 17:51:53 +0000
Message-ID: <6F8F3C24-A043-443A-BBB7-E4788FBE29C9@oracle.com>
References: <20230317171309.73607-1-jlayton@kernel.org>
 <20230317171309.73607-2-jlayton@kernel.org>
In-Reply-To: <20230317171309.73607-2-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CYYPR10MB7651:EE_
x-ms-office365-filtering-correlation-id: 3d092f80-f340-4d92-d4e4-08db27104afb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ysrZi7JXsP9MrpGVcat15+xnpqyxPn7UGO0+UFR6FrkZf0fdOmhBpzGole48Jd41MkAKPG/QcqkkPMSHVdvc51zJ75pYrR7LJNP+7/VjrWWe10RFDLqx0EanagR0Dd5Y4VpoVR50tLcA3JcZbLoqUXi2bOAjsaUpbeE8cnJ5vmIXntaXNTEnsK3hskc3pP8kSQ9gDGt4v/xMX6vwfux1vF2PPlX3YXnIzFUyJXHsSxQ8B4DIUfmBnD79joPsJ42EIFlrzLJC969eoEgcjX9UG9bYAi1Yw7vZ6lxO8NCaLel6bP8gPDUEQqU9LJ408EDQUya0B75YiGLndDRkOgxVHn6hsy5zjw6J0we3LajQAaowdfNUdTPzlxyys7oh0fE+NSy6IRI4vmWo04Ys42fDcAztTQzjpn5I8IZjaFrpHutrJwgCQyh1tQ7D0AXSNXaBlZ0+ZrLsYnOn3EpJF2q5zHPJzeTjg0MxF431vST4ymKsU3n93e7zebJ7fU4VgXVg117CNjHmcxrrn/MJHq+wHHv9xCU35PRqV3bmAK+avKDSKdo+wZrpaxZc2mUTLSXyLuirValR7/PvaTkR/3sEHpfcFJ5AL6GV70H+CTqGenfRvYiKvGqpJMAv6vy29nwa/fSy3EaFQ4JHs7QQK8j8gcC1LTQtHHt3Hw1k8u0pFS6FxYLuPlstZUoKHKtHIPiXSVvqSx8WeIpN08Mu44BHuEQ/RckzRyAjkQBfCHvHP0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199018)(38100700002)(38070700005)(86362001)(5660300002)(122000001)(36756003)(33656002)(2906002)(41300700001)(8936002)(6506007)(2616005)(6512007)(26005)(53546011)(316002)(83380400001)(186003)(71200400001)(54906003)(6916009)(66556008)(66476007)(6486002)(91956017)(66946007)(478600001)(4326008)(66446008)(8676002)(76116006)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Qmir+dZFZhxEDdaRz+2otGWHEEOQAk+qFW8PUVFoBpRmRa7Q+EAa2eA6QxE?=
 =?us-ascii?Q?dO9I4LJgbQYrKA+/RFqy0yPhZywcPdYpDdB6QXhBR4HGLElVV9grcf0AswS5?=
 =?us-ascii?Q?nCblLM54KwzlfnXEKD8AS6goKkSqtJzxsirGXyXE324jRu2lkacaUsnhRRyt?=
 =?us-ascii?Q?TsejLhuR9og/ACd9RpqNxWjmTekc4EUHVpmp2g9i0sQeLmyVDyvbe55vXOru?=
 =?us-ascii?Q?faW279w23osHmhoTps+H5sM08QiKbpXdTMtgDaCzu9HqlzM98VzSQDbQn0I6?=
 =?us-ascii?Q?oeBEvUQrhsCC4Qv+2JhsVkdwJKzTH2IroFgmUrZnilVyvjzpjG3kGE82/btb?=
 =?us-ascii?Q?QeSgiCmLqFn6naT2Xpv7AuqFYcc6OUSfLhVhePhV0vGilQNnv47MjU/kS19l?=
 =?us-ascii?Q?eSYXqCTFe+YdxGtS3xkAZSskYiX0HgKkoiRaYGjQD4+lirvmLLXBuj2YC8V5?=
 =?us-ascii?Q?xiaOF76tS/WcbUh222nTFzgfgusBY+TdfYLhPbiuDjfNI0GRZjscIuW//sLn?=
 =?us-ascii?Q?H3QK4rUjWml830MYAXEs/RY5TJG1EgMtIy/gzYHB3zPkU9e+gw3+TwQm1Mmk?=
 =?us-ascii?Q?/8qXhfy5/xim77hgbwxGdibq+fNQx48s1F/mPcB16PTQiqRkyh4N9uoWW7S9?=
 =?us-ascii?Q?4rdCzrNI3AMEGuYCiGwtJhvvvAdJmDxvrHegcEeAZ5f6fbW9adSvNBvN0wmi?=
 =?us-ascii?Q?kknmfhTBHrD1GloWsQKps+9zNqVP8/KQSqW61KE8Z4PfMOBXvowND8LSZdPX?=
 =?us-ascii?Q?7bO8R76AyAOirXDX0bnpMaFj1wvgAfKMpAQ38NaoA+zAAERhrKXGHf1jvThS?=
 =?us-ascii?Q?8x5HwSblJE52K9yci04bp+pvIro5yxypHwDVP8ZCL20zvyWx0D9zdQ/Zb/6G?=
 =?us-ascii?Q?S3ZoDqFJonedGGfNJj4AzMNAts8KsS9MEm9fAeWZqPY9TI0q4WwvYpDcFvst?=
 =?us-ascii?Q?ZGMsatuI3W3MB6nY8sTOz0N7PCKG//pqJ+NMOOAPoMSdcaCW2YuEvTvWNBQM?=
 =?us-ascii?Q?p4zveNR5TqpRNpWuE/KraOK7xEk2y8NiY0NLrEhOSmoluJ9CbHLUCOLj2iXs?=
 =?us-ascii?Q?TiRTg2ERwrKuuhmRKOQ0M9CUpwSaI/ssimcHUdzpCNwTg4pFT1hUAdoTc2yT?=
 =?us-ascii?Q?sl0AekT462YUcnbLjvwk2IcURMgkMb1B5nLhBr2ap82rhTamlZs1KzcLPY32?=
 =?us-ascii?Q?imgstQmMvqcXFrQ4/vTqhYeQi5n3oC0SyIF/A5O7oyNH/6LuU7ObPHPFWJ2k?=
 =?us-ascii?Q?Iq3LND3lzNqbdKRt0J0VyANXgjNOgUdxnBeXxbKahQLRNPOXZxjuUrTvKPiJ?=
 =?us-ascii?Q?mbRNPMJ1nUsaSPdgxlrqo0m4XwLkuY1TcC4w6d6QyQq5JrgSDBvDvUs9fL32?=
 =?us-ascii?Q?E2zC17bE5CuZYtgpENeZW6Yu8Nmj64wCV+l4Wmqv+HwZ3ekksh1wFSAql0qM?=
 =?us-ascii?Q?ZHSErn/5lEbgCBDKVCuAEkff4YPMh7qjBA+2eMCaepqilNXVzKEkNUbEzOcF?=
 =?us-ascii?Q?gJlTT8wO0fbZAO94fkHPS7U5L6pPclK4DmKTN5iiiAfIXKQZFFWIMcUzHHnr?=
 =?us-ascii?Q?LXBO5oPFFscYBJU8dPA/IUO1npQJ75OGQzgYwFhxqfTggGMkJUuY3klFHWvZ?=
 =?us-ascii?Q?Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B657B6EEE5BFA74F90C45EC5FC0BFCED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5CxfH0grUbl6LIPaEyZ7Miare/sBaquG8jJ7UjSy3+s9vJYZL0Maeel3/9htxmB377jjU7bJMrsvTJAaKbRL9LyxubIAJBP25Ox2HiGH7zHoYGDifTNj6DNY1q8y+nzH5+ddIYREgJntNvJKPzrDHirHBMSPIqI4xBbX4Cry5hEaxjsQPCXlu7gp1ellvbwMBsJHfV9cDoZuHe7Gckdc66rf8QW3dhxjQqadgvjFxEyuX7MRukguYqXqseNGu3znrd9VX9aupmSIA0Q5TPM30QrCtJLnDmoDTOprCdfV2EovVQYxOTMg9G9yM2FWzuXpd8MZCLV1oamcRASz1pI8TbAk13IS6Ta7pBOI4JTQU6yU3TP5cud/Wt4uRV/7fawAIXrQrhLofjo0YUHG9zjD1w6la5GJLdUxwujJKxS1TsYuzwLvCHoL7SH1YxaJ2E4UQ7vOn763Y3PJp3sKeJIHjDPpQXbbE5l/h6M0kTtQvabLkRB2xAUaybiGrVr0TOBuL8NvM1BHPGXRTPUjjUPKSJrNA9WCqLlfAScOD75BmkkC+8HlRb6L3j7atV/bAm55eoYsVQIH1O+uJ6F+unV6HuIgej89SOfY+zz5/d/1dT652TvHgK4PYj3rmbjjcjxtIm2aTVRWltUXuVii3FhTutJIfNtH7Xgei5AEarmLmF6hIm06aB0zle8RMMsCWSXTIH+oxVSAK4PGaPzm2CjODlhGjVUIZUaQSUcu4M56MPhFUAxRfRlAKUnByH8XwkzKG3+eyr4TnVobxH4pTKxd4JpZgyKB33Ef4RMfcmG0Rbe8506A/8pG+Ub4Hoy/n0X43YVtuNDiUwX53gwqpbomaEbcNLcc6UoTZi/nFtw6lrhiOslO0wXI8RtHBYp+79j/CoV78VhGou3+vO6hBs7LkQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d092f80-f340-4d92-d4e4-08db27104afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 17:51:53.3878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRb/TA6eaaXIeATFNHsAE3MjSkHhNR1x+xSnctWn/1i5h2xNgRoTGMHhr1Y/Hb1hRxvKZzIzcS0kbs8G5buLiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170120
X-Proofpoint-ORIG-GUID: emneN9U-75hS1mDGuRrghWSzoXXprlQu
X-Proofpoint-GUID: emneN9U-75hS1mDGuRrghWSzoXXprlQu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Mar 17, 2023, at 1:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> If rq_next_page ends up pointing outside the array, then we can corrupt
> memory when we go to change its value. Ensure that it hasn't strayed
> outside the array, and have svc_rqst_replace_page return -EIO without
> changing anything if it has.
>=20
> Fix up nfsd_splice_actor (the only caller) to handle this case by either
> returning an error or a short splice when this happens.

IMO it's not worth the extra complexity to return a short splice.
This is a "should never happen" scenario in a hot I/O path. Let's
keep this code as simple as possible, and use unlikely() for the
error cases in both nfsd_splice_actor and svc_rqst_replace_page().

Also, since "nfsd_splice_actor ... [is] the only caller", a WARN_ON
stack trace is not adding value. I still think a tracepoint is more
appropriate. I suggest:

  trace_svc_replace_page_err(rqst);


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/vfs.c              | 23 +++++++++++++++++------
> include/linux/sunrpc/svc.h |  2 +-
> net/sunrpc/svc.c           | 14 +++++++++++++-
> 3 files changed, 31 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 97b38b47c563..0ebd7a65a9f0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -939,6 +939,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struc=
t pipe_buffer *buf,
> 	struct page *page =3D buf->page;	// may be a compound one
> 	unsigned offset =3D buf->offset;
> 	struct page *last_page;
> +	int ret =3D 0, consumed =3D 0;
>=20
> 	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
> 	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++) {
> @@ -946,13 +947,23 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, str=
uct pipe_buffer *buf,
> 		 * Skip page replacement when extending the contents
> 		 * of the current page.
> 		 */
> -		if (page !=3D *(rqstp->rq_next_page - 1))
> -			svc_rqst_replace_page(rqstp, page);
> +		if (page !=3D *(rqstp->rq_next_page - 1)) {
> +			ret =3D svc_rqst_replace_page(rqstp, page);
> +			if (ret)
> +				break;
> +		}
> +		consumed +=3D min_t(int,
> +				  PAGE_SIZE - offset_in_page(offset),
> +				  sd->len - consumed);
> +		offset =3D 0;
> 	}
> -	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> -		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> -	rqstp->rq_res.page_len +=3D sd->len;
> -	return sd->len;
> +	if (consumed) {
> +		if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> +			rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> +		rqstp->rq_res.page_len +=3D consumed;
> +		return consumed;
> +	}
> +	return ret;
> }
>=20
> static int nfsd_direct_splice_actor(struct pipe_inode_info *pipe,
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 877891536c2f..9ea52f143f49 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -422,7 +422,7 @@ struct svc_serv *svc_create(struct svc_program *, uns=
igned int,
> 			    int (*threadfn)(void *data));
> struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
> 					struct svc_pool *pool, int node);
> -void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> +int		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> 					 struct page *page);
> void		   svc_rqst_free(struct svc_rqst *);
> void		   svc_exit_thread(struct svc_rqst *);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index fea7ce8fba14..d624c02f09be 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -843,8 +843,19 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
>  * When replacing a page in rq_pages, batch the release of the
>  * replaced pages to avoid hammering the page allocator.
>  */
> -void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
> +int svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
> {
> +	struct page **begin, **end;
> +
> +	/*
> +	 * Bounds check: make sure rq_next_page points into the rq_respages
> +	 * part of the array.
> +	 */
> +	begin =3D rqstp->rq_pages;
> +	end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];
> +	if (WARN_ON_ONCE(rqstp->rq_next_page < begin || rqstp->rq_next_page > e=
nd))
> +		return -EIO;
> +
> 	if (*rqstp->rq_next_page) {
> 		if (!pagevec_space(&rqstp->rq_pvec))
> 			__pagevec_release(&rqstp->rq_pvec);
> @@ -853,6 +864,7 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, st=
ruct page *page)
>=20
> 	get_page(page);
> 	*(rqstp->rq_next_page++) =3D page;
> +	return 0;
> }
> EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
>=20
> --=20
> 2.39.2
>=20

--
Chuck Lever


