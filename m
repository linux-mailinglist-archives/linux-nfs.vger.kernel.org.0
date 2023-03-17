Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328AD6BF32E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 21:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCQUzy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 16:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQUzx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 16:55:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88A5D89D
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 13:55:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HKeXwD014373;
        Fri, 17 Mar 2023 20:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HgR06tZpESaYnMbqTqrp8Mgh8mUEuEckXQ4+1ePe7Ts=;
 b=0eC7hiNzh5f6fmzhsxiad3+fJronX+IfmFNphGzWY4tzb+GMC9YWiAhAFFeF5s/7BQlN
 483RLzfsuWMOFLixl5qMq4D7ylPbMoLtiBW1+w/SJ7qLs1anVIYrB6k0IjDskyZgrmIR
 9w2LJrerwCZL3N5ialSw1SDYBI7adA0uAgFfglUeWpbuwyPlY+2rwKOMHUUNSEzzuIJw
 sQcKBdi+q8wgDE6T8g67YoaywlXc7JI80hhvyaF8KyeZ5jtzSMaXxwfidCU74h8GslI+
 RLOTkGuhJwSHMqtiHiZS5fUpCrN4pzDE1RZDru71g3U1l7Ppwwgs5MCXTIx7yvahF/mE bA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29vr0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 20:55:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HJL44t001139;
        Fri, 17 Mar 2023 20:55:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbqq77qyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 20:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSgC1vUbtD1/o9EhgGd2BUVjb9iNA2RmNQLhE5F1fgEM8dFM8DIDOZoN5XG43hc7oegC3RYecHQo8IZTl+9WUziGiksdogyUf/q4zt0HQ92Y1e7TZSlUnvHrn7vCFZicftYvXMQ7foqoSGioagIoiWWiQttUMSZjgMIsLGKPPjFDRsPX02YkxXr1WhYCDm1IihLC9S1JoDk5pus74ivRZa2d717zNu+vr1XHt5GpZ9QJFd7XI1SmSVY45V9pyjxFoZckg8UbVJmrqWg2XzRD26ndLXBOvEXcj2/cAZFCAAl4fGXxkFdzEppvI7eiFAx/+nmIdmeeJeYT6BpaPZ40UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgR06tZpESaYnMbqTqrp8Mgh8mUEuEckXQ4+1ePe7Ts=;
 b=L1sR1z1kyVNw58IfUD6T0R/pd8zuHl/eB4gq4105H1SuajylQET+HQgkLGNe+5nDE4fN2VrGYudCJjugZNRknLlDp9akzbWVlpVJa5AudncrY9Wakq7k9NnBg16muDc2tWGQK91RhC+poiyv7f6v0iv/sadBypTGknMazzme6PhA1078fkFjRoV5mv37wXX4D1Imz89yYhqNB7rp8Nd06gyHMyc/0E6FsEah5yCfmCzbOZtdom+KilVBnBifQ9L0rpVcpsrRLvvuajqHMiEkNivB03gpent9jh/jHoMbxiOuREnT7oQUfup2ZroVaqdU88HAGIe2IUAi7BjuVrIVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgR06tZpESaYnMbqTqrp8Mgh8mUEuEckXQ4+1ePe7Ts=;
 b=odhEbiFVowXv1InZnFMjimclw/yO9BSA0kqMiBhT0O03YvmEHk9btvlu74JdqQY/+garvKw32Vqs1S3s7qGe1+6iSvwfyCc2vX3YUiq8dpT/RAUNnL1vBusIL+Rsz+VGK7pDkjpUAU26hv6lxjWKMlnerPyCgBdnCSo99Yk5ntY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5820.namprd10.prod.outlook.com (2603:10b6:510:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 20:55:41 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 20:55:41 +0000
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
Thread-Index: AQHZWPPHhxprfvZio0CVZD7mRL0pxa7/QGmAgAADkYCAAAD6gIAADlIAgAAgfAA=
Date:   Fri, 17 Mar 2023 20:55:41 +0000
Message-ID: <27346F71-367D-42DF-85AB-D168012F5C41@oracle.com>
References: <20230317171309.73607-1-jlayton@kernel.org>
 <20230317171309.73607-2-jlayton@kernel.org>
 <6F8F3C24-A043-443A-BBB7-E4788FBE29C9@oracle.com>
 <827d46876b57bec309164d4c9513bac523ad5843.camel@kernel.org>
 <F6CE9F70-628B-44D3-A8B1-D4EEBBA28B87@oracle.com>
 <c78fff223129f289214ceada0d82f6952e0d3a82.camel@kernel.org>
In-Reply-To: <c78fff223129f289214ceada0d82f6952e0d3a82.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5820:EE_
x-ms-office365-filtering-correlation-id: b2ffe162-447c-488f-f0f5-08db2729f81b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zeVXKxcAohVbXKdIUkftsNysRmXAK4Fh52Jr7wRy/X8yTbvJB+OKcaYgTeaCA1IJBsvTqdm6/FoFQLIoQg7uU0OcpGl71KVA1W+AX/IY8fEvkkyBjCU222lKD3//H3/z554xO2dLYpJGUw3/8896hTOrKm55NOtzNZ8H+ye7tUPQiwCgNeDjEas2YK/axzJpyNsQvVs0rYKokgRbkbZF6FrPHnEyHNeq6Rpp9UzHIkvn+SZ+IoaxrYf3MM2nUasAMdpOM0lPXL9j7vVpiRX3zGhwEyhmPR5x8tcEx9DeeE9ut59A0CZPRAMDNdSTuaYtN2MJNWCWxG/YLIFch5l3h7CRyJWtPe8vkDpVqk604+wm6fTirWWpB4vqTRe8UFe+r4Lk5irVyA5eiKActFC6YR9PvO51Zy7dgnJfBj7lLa4Vwlusd1qeXd+GxP+/exzAYLVpPW7jzRul9QS/f87yUZSgXcwYRYUFhcN9tAjUL0Ao9LyhwYy38aSNyNo6kpBXJG4ZsOqkXYyNTJy8ThhfIyZomLL82cQASJrIRkXNdFaPwiM/bbBGI6vxUExd9S9xE/bNDUHLlIu6SCZ2e7I2o61BsutoF0igc2PZwhzX4KbVQYiM40JaZrMiLEDU218eUGIZbg4CqCRTLfgIKevEdeEL/2SszJHF/J2AALvTaXSqcAZ8QLPTzYGinReNtiq1zbLj36yJjbcn/6Cy/73Q9xfttmw4zCU/S8OrExXO/wo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199018)(71200400001)(316002)(6486002)(54906003)(478600001)(186003)(8936002)(64756008)(6512007)(41300700001)(26005)(6506007)(53546011)(8676002)(4326008)(6916009)(2616005)(5660300002)(2906002)(83380400001)(66476007)(86362001)(122000001)(66556008)(38070700005)(66946007)(66446008)(91956017)(76116006)(38100700002)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bz6/7LgwKqMCJiZBV51RzKxB7cjcADDSzLrhvNXTdtzYE1qOxSAM46XPFxwb?=
 =?us-ascii?Q?osGWqMXty7QleHobSJdMCgcyTUdNYzpicsgXhLxaJC0RWjAsTfR1JR8MO2Sy?=
 =?us-ascii?Q?MX3nLorFBcHVVgywhB1RO41pC8bx5EOyn1PNo6roA1HL+868w9AFl2/HwgMm?=
 =?us-ascii?Q?Pf9EiiWpVsFtIkwH4bYIxSByg5yBD+UJ62OtJAE/7E+fD0KqmonlT917001h?=
 =?us-ascii?Q?zxIsa1nsI30qkSBGQfsynvvgzxao6zbZNzChoTJ9CrKCw2NCOggfOuynrT+n?=
 =?us-ascii?Q?0KVTsjOyym56g5RAJ2vZ3GxOHst+13FugIv+NGEuF9WVUCCUsQJtLCbzSOOx?=
 =?us-ascii?Q?6FeFhsKLTc2zDh5YocucZGsa/MdX6yfj9QhaHX8WJV3bjiUGLyMj0VzegFp8?=
 =?us-ascii?Q?HioQmicha0A4pgegD2zY4PMbEFkp03NRDDe/AeZ13QEg1AjkHwvXWiCtxPIe?=
 =?us-ascii?Q?onH/9Hj0jW2BmSUJPTvyyBdVBv0ckAvRXZAmrTx9l1tSQ5eB9gDpSiDV4j+r?=
 =?us-ascii?Q?CLGTUg4EVwYxvyr+j7lOGzyiuJp/V45j0YgcfgpDgBJ6Ryj1l+488Dbf+asB?=
 =?us-ascii?Q?4iCtm6Ih9FK9OzTmnoD5BmuEfWusy1um6iO51lO7Se9LA6J+8rPqen0PzpRH?=
 =?us-ascii?Q?xlmkhuKEOcRdg6j/NOSzTa29Z9iYkYHTBUUYfEgbkLD6UzQ5hdIomLbxZIIi?=
 =?us-ascii?Q?a3krEeWpv8/VTPQp/pxgfrzgWpu60LopyD+BIYKBLUjRj8MH9Q3y3otXoqoa?=
 =?us-ascii?Q?SajwQCSd9m2/qudBhX0UMoaYnFoeEhmHUMl0SYiRhPur2ut/gaMhClWUZMpF?=
 =?us-ascii?Q?EIy+/hztaDR9Nt/Gl6xEfWGdq44ZLzNtnNsRDAg8tM6M7PLrZ933q/LyX9yg?=
 =?us-ascii?Q?hZ2+yw8s3K1umz0dVTkIeT+xTR76Y6wFSRiPBVJqZcpxZntp+RFXsTMy89bj?=
 =?us-ascii?Q?6utmjuunOa7yuCV6xkA3YwJWwCAqxmC3b0nukZyKHkZsGFBkqSOO82YTJXV4?=
 =?us-ascii?Q?xscQ2kRrwCEBD7ipQgBEzPVr70VznzijvIPRhsEiq1cxYhgvlUGrFz9oqILi?=
 =?us-ascii?Q?/2eFvTyG4Bg679JaWGEdMtOKMQJXj9BYXJOybSnLaD+ZMgAmre4qA2I4B/3h?=
 =?us-ascii?Q?MWJV7kbpPSL+/9H0zlK8AyzzOUdDkyASm7BQzge/WYQOh/dzB/YgLzzak3Rr?=
 =?us-ascii?Q?LCUGph+QJ323iECwvP7yGFDdEwpaWN+177isAtgtbqlHdX0Hicr7PfY7o338?=
 =?us-ascii?Q?8agOnCidmKIo44GJHEsoRUIKrMbJ2Ase/wRD/be4eEYxXbCgl+Vx/BUU9YXr?=
 =?us-ascii?Q?FFel05fNl0HSXnQ9lFQCXK7XgfXIPJRd3tuiowJNZfuMGraugY2OXcceCq16?=
 =?us-ascii?Q?6h1++Udt6PRJiWZ8s9Up8GAI9Kr/UghKzX1J9OKWAR2dTEc0PM5kod4lwxfg?=
 =?us-ascii?Q?uuBjjiJWbJKL3aYcaA6SgqJDLo8VoG2Z982QFW+f0Br6xod/s29/KTTIiTEa?=
 =?us-ascii?Q?SZmVXHTvBnVBgyscNIBCIwlF5KnYsw4k3+O6rnaFRX2NNATNIVio2XGTRpRd?=
 =?us-ascii?Q?Qz8qFRCmJvOLnEBSoDppsfgGm+EuV7QeWp5L+CmvajSQNVXMZqJd58oSrLzh?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F6FC3C3DE92C9469EE0D2AD4E1E0220@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 547G/s6j+DevsplhKnoofsNX4F0uHdpRX50StmyFEuvlTALRsknXW6zBk/x574FSHbwEViBRRsht2/bHXcYI3mHzht9QTHuo7g0FCVaDrHkfh6/oOd82OA8K+rwu2GcaQ5ZaG3eb2K0XUewwp0rbQdRlW2bI5F8t8Whfkdtb5ax0a7VRMFEdKLGzLniLDB7D5stRSY/AbEi/4jwjfGVnkm6Ol/aq2SBvXuYRfHLnp4Qbn6ItrwvQOlA5UXL7BNSglusR0oU+j/jy9M5bGDevIX55v7I0yzbdClrpxW56hpSn1xPe/lpOm3LBb5Q5vhuOhBEcSfvSQGmCWmCUTqEGSaFLt6Rp14M5XPjUrR/co7gJV3oSAaXu/+kvA6Lx7yWT+LCBGlf8pQfJCmSJU8jIxJDaw5/AddELDcf+IKRaLZqeaHg6k3/MYV+/MYemzFaPnnMJZjmJwXUD74Q8mPA5QS+bonocFCG85+E14iyU9vhmC3IS7HRYUPHk1UfocQ5Nsc9hPwoyzt9aIeUNnD3nKt099ndK570w80W031pzQkenVnzKQKYaj+34GfAvTndscYcVP16WH0MzhEF4w29oAlBnSVpe0df1os0ULMC5OEBgQtBixQmCA8ZsipqR07LSg5OiTvuTqVr/bHm2BhKngXA8fS2BKMQJDZSPV7aMvpBJMbjolaJQl7rdT4Rwae70e1nUw7anKHfJqtE7nDPyktO/p1qncfeS01ekKldelLkfR5ije1P9HHzJeap9plT8xkM1i9GbukteHe9SiD6KfeVkqeWtH5jXK7iU/7mL7DcK546tileZEZ8A0/OQRFgLb/Q1F/KyBNMwpS+axHUZPJSzvuz21jMlKgU/Phze17rIinvW1YdCMiuxZgDKMLxhFlDouYKvQZIJULZUBrmBsw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ffe162-447c-488f-f0f5-08db2729f81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 20:55:41.2467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEtMEB99o5SK8brcOO2XNForbom+aYVFkMof/npCo2PNUVkmMQ5CVuPaJ5+zvG5H2oXq3i2W1Zfkghfs/oIVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_17,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170147
X-Proofpoint-GUID: 1VRcTp2b-75cJeJKdfO-5iUHMd9YSt2O
X-Proofpoint-ORIG-GUID: 1VRcTp2b-75cJeJKdfO-5iUHMd9YSt2O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 17, 2023, at 2:59 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2023-03-17 at 18:08 +0000, Chuck Lever III wrote:
>>=20
>>> On Mar 17, 2023, at 2:04 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>=20
>>> On Fri, 2023-03-17 at 17:51 +0000, Chuck Lever III wrote:
>>>>> On Mar 17, 2023, at 1:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>>>>=20
>>>>> If rq_next_page ends up pointing outside the array, then we can
>>>>> corrupt
>>>>> memory when we go to change its value. Ensure that it hasn't strayed
>>>>> outside the array, and have svc_rqst_replace_page return -EIO
>>>>> without
>>>>> changing anything if it has.
>>>>>=20
>>>>> Fix up nfsd_splice_actor (the only caller) to handle this case by
>>>>> either
>>>>> returning an error or a short splice when this happens.
>>>>=20
>>>> IMO it's not worth the extra complexity to return a short splice.
>>>> This is a "should never happen" scenario in a hot I/O path. Let's
>>>> keep this code as simple as possible, and use unlikely() for the
>>>> error cases in both nfsd_splice_actor and svc_rqst_replace_page().
>>>>=20
>>>=20
>>> Are there any issues with just returning an error even though we have
>>> successfully spliced some of the data into the buffer? I guess the
>>> caller will just see an EIO or whatever instead of the short read in
>>> that case?
>>=20
>> NFSv4 READ is probably going to truncate the XDR buffer. I'm not
>> sure NFSv3 is so clever, so you should test it.
>=20
> Honestly, I don't have the cycles to do that sort of fault injection
> testing for this.

nfsd_splice_actor() has never returned an error, so IMO it is
necessary to confirm that when svc_rqst_replace_page() returns
an error, it doesn't create further problems. I don't see how
we can avoid some kind of simple fault injection while developing
the fix.

Tell you what, I can take it from here if you'd like.


> If you think handling it as a short read is overblown,
> then tell me what you would like see here.

It's not the short reads that bugs me, it's the additional
code in a hot path that is worrisome.

--
Chuck Lever


