Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E767C5521A5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jun 2022 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiFTPzK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jun 2022 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbiFTPzJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jun 2022 11:55:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4451D33D
        for <linux-nfs@vger.kernel.org>; Mon, 20 Jun 2022 08:55:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KDDfUc013057;
        Mon, 20 Jun 2022 14:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=huakZdmv6Sp+ZrjF2BbCgmo3OtEVIdajG5mFjQA4KG4=;
 b=LLe9NkfX++DOPMZK1CnHdspwFFhKoZZROUhfxQ9bYrzhvg3U1MCKKm343xDOQRBNFj4o
 9fRUhPTWjUWZ2TsIpQ4L12MEBtdqb8s+mTba3og0ZFZM4EMKkJv8S+Z3SlRfb9CGoPRo
 XU0ikcCY8/kYgUpxRUccGU3Kx1+PGxStEt+gSrRUOBxM+lPfmBR3+E7QBelzHAXoQ8cQ
 ukJ3hLUIFseB8mgNJBssf0cBbEEyKkk+Pp2+rTcbpN1HvoXcY5vJIE6ZH79ahA5/gLqL
 ideQdT/4SxRqs8RcFZdG6nxSSBernivw7qcucRKzbwthSS+iQBRcMofwHtP4dn66S6AQ Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1ue3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 14:11:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25KEAUAJ027840;
        Mon, 20 Jun 2022 14:11:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9t8qex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 14:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akGpDFjeRCbFw92z62fmAOci33yr+vPEfkZdvJOfdzbMxwPPFni8IxPaEmCW4jkwtq3ZQPNhk/35W9chn86huCDzXT8HV6wfE2jD6e4CZla+xpY/YG+4K4DwLUfb/xW3haCeO5eCTCeP7axntni0Cmgj6ijCzlF11a7yUU5r4XG3tZzEnI0Wq7ZH2prF7zSyvBl7AbmM5EfubolidC39n3v4cphS4IDXAOkDaG0zyvknoaTSn/wrAMYCu98XLy54AmmPC17Hjf+Mwv7ZsqPAungQJWQZPeqNDTjqK/afZxrTXr6lwKL5EhimIfvazt7PWUJ0ebqJycf3N3yvw8IT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huakZdmv6Sp+ZrjF2BbCgmo3OtEVIdajG5mFjQA4KG4=;
 b=AajTjamxLltgd0vxxqip2452F/O9gDqd9+NrUIYZAttIv+dCALp/JJDfZdz/cN54Bw7juuxalhH/G9skJCZsJi8hZ9So62ELtuYUX+vagfibotwdlDWrmxJrsIuBYAGoI5eRo5J5YGNlh49w+dH8jQVtT1oM08b4YJvWirr0wkLPgxBRfKOzrSuQOAxBlURTW7FBz9pB4ffxjBUE4MISjoQFj/oYDivUqIVf8pdN1DBl5nzShnh2NMWx8bQJ5EmV+/3Ts8h8T5UuokZrP3cBRD2BGfwLO9b2J+YTRy5THPltY22WLk93V+TLmeJKCSIPWuQVLDDlR+wacT+53DHj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huakZdmv6Sp+ZrjF2BbCgmo3OtEVIdajG5mFjQA4KG4=;
 b=eG26ALTgw+fElOS1CcrrcnmvriGInxaihrDnkVld9DItfhnw8RAVLmEdC1q2bxjm+PhttpSVV4Ltr6TwmCQg0y0toLluh/1IqPIGgS7o9Td4FEh0wtNtcvJlKz99n1x56b5/+UyJJu2bdq4cvmfKTTNlQIF2FaNWeunQmdvHvYQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR10MB1585.namprd10.prod.outlook.com (2603:10b6:404:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Mon, 20 Jun
 2022 14:11:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 14:11:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFS regression between 5.17 and 5.18
Thread-Topic: NFS regression between 5.17 and 5.18
Thread-Index: AQHYWwCixuCyjj49XkSuf+bm0GIRX60Faq4AgAAMfoCAAERPAIAAApwAgAEchwCAAAwEAIAK/HiAgAroagCAABmggIAAGOOAgAYzNACAAAZIgIA1BkCAgABriwA=
Date:   Mon, 20 Jun 2022 14:11:39 +0000
Message-ID: <C305FE22-345C-4D88-A03B-D01E326467C8@oracle.com>
References: <979544aa-a7b1-ab22-678f-5ac19f03e17a@cornelisnetworks.com>
 <8E8485F8-F56F-4A93-85AC-44BD8436DF6A@oracle.com>
 <9d814666-6e95-e331-62a7-ec36fe1ca062@cornelisnetworks.com>
 <04edca2f-d54f-4c52-9877-978bf48208fb@cornelisnetworks.com>
 <ca84dc10f073284c9219808bb521201f246cf558.camel@hammerspace.com>
 <bb2c7dec-dc34-6a14-044d-b6487c9e1018@cornelisnetworks.com>
 <A04B2E88-9F29-4CF7-8ACB-1308100F1478@oracle.com>
 <46beb079-fb43-a9c1-d9a0-9b66d5a36163@cornelisnetworks.com>
 <9d3055f2-f751-71f4-1fc0-927817a07d99@cornelisnetworks.com>
 <b2691e39ec13cd2b0d4f5e844f4474c8b82a13c8.camel@hammerspace.com>
 <9D98FE64-80FB-43B7-9B1C-D177F32D2814@oracle.com>
 <1573dd90-2031-c9e9-8d62-b3055b053cd1@cornelisnetworks.com>
 <DA2DB426-6658-43CC-B331-C66B79BE8395@oracle.com>
 <1fa761b5-8083-793c-1249-d84c6ee21872@leemhuis.info>
In-Reply-To: <1fa761b5-8083-793c-1249-d84c6ee21872@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ee24fb7-0ceb-42a9-1698-08da52c6cb1b
x-ms-traffictypediagnostic: BN6PR10MB1585:EE_
x-microsoft-antispam-prvs: <BN6PR10MB15857C724146B6D069E87ABB93B09@BN6PR10MB1585.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cMCsGkQaHutsH9/2SOMyvUPd8apgrJ2f8pQab21llPI1kB8zpbC4sisH6sJQT6Oqh/+LSxQx0LdM5YFgIbEJQoSmNFzKHWpYxaGjbWULDomUk/OyrWl33KudL0bYx3Pkn00LbvVJHG1A9bwHumEKznv6lKjv8tyRuMvi5c3Ca91QfNsREQUPQS3VymkwqJL8rlpHwuIGZCzB2Emvao8E/nyWYygRka44L6E3dSXhQ9MNXK2duC2ylEvTHjXSuH5I1PGs3JZwGRZNv/4gbMFJ3b9JRoWF6DjyCLAXQ7Ll2zDktNGVfpoEf3+b1102l/3xN2fMx27TBps+nXOqURrXRJOUecGPFyZLp8kAn+GepHozsq1RWZg/KAmq06sw/pB8Du6TheT+/ft1T/5SV6rNJKPHIUs+7uSIUfTfNS7fqAYuWxqlh+E0MG/ISLSAQ0C+Wmmz6g1dAMtJnJRFBs8Y8C9BuJ4tM5AS5fKmP5D0fxT3hbRdNJ3QmLUDuLrWwH3x7GMhZIBK9IA+Bmd8RJkJuDkCcM4X/ijc2af2eFhX/o65YVreQl4M9tBZ+jaDkdRMg5JpP2zSpLeaW9rgHvrFktc2qVvAFFxvrTBnU6anbHbkMZxh/JhX1iObi24zZXwf4oA/kwrD/ep1clpTGoerjNmkbUWnVMPtlaYNU4xa7UwtR9rJ57NYCRfvMJ2G0Tk2qRQaaZ2Jf2HIxiEViF4sTecQktTjpxFKZQcigIjlYbAUMpso1JDJpUh45KP5WESe4KofU8h/dmass9ulCmDgr6E8XClBlChlHlgtpvnqDEv5rCmPQr4kNr0wWUPf0DHn2OLzFfPG5FmT5QKHN58Erg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66446008)(8936002)(66556008)(76116006)(8676002)(4326008)(66946007)(66476007)(91956017)(6916009)(54906003)(966005)(64756008)(71200400001)(5660300002)(2906002)(316002)(498600001)(33656002)(6486002)(36756003)(86362001)(26005)(6506007)(6512007)(38100700002)(122000001)(186003)(38070700005)(53546011)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZT9+kCjz6HQQT9VgH+dAr+u/cccFAjJpNgHuodUBKbtOxpFAd/HhTVUKJUR5?=
 =?us-ascii?Q?uCKrd2m0zELjnJo6MwE6UGPUX2MTeFvA3aLTUfXh9UhsjmSN+9uEtLI8y6K8?=
 =?us-ascii?Q?csUTzNTxfyFfX/ESlycWYJZQwk0L4tABE0SeVxWQMdSFxSKMQ4jga4rSHF7e?=
 =?us-ascii?Q?Qjqj0xUx0GJDKUzq9gatEJH+QRORjMQXYY0yu4w9cwU2K2ypniS21yFiG46E?=
 =?us-ascii?Q?FiI9GZyuRLWBxsC0F2xIE3z4lVZ7TdmCTRfR2cw43eUzUVXDK9G7qN7Y9+iF?=
 =?us-ascii?Q?HgBSg1/QlqcibLbCfDxLnmLLYRcykphdLvZpCGtzGJkrZD1bL51cF1SkxYyf?=
 =?us-ascii?Q?kAUMwBKYOhHV/Ze0yYw++wMAyRfiTG+9XwUQXVwtuwlBopm4TIZzxXLDNOAH?=
 =?us-ascii?Q?ufFP1tBQqMn/u1/BoAFnvjFgeIvOx4I61vB2D19YPbtKX53F76Tll9tvF3tv?=
 =?us-ascii?Q?Pe+vKq1aRe2exREO9zc+kkFIa5DCIQ9kZ5hcIC7IHClhCnTS4NIIJn/+D9WO?=
 =?us-ascii?Q?Y1BZy0CgEpjA4ip94GNzU+VzugpclKMUG0Ic8be4rayqaYvkciCjjqbFbrfj?=
 =?us-ascii?Q?eyb5b/Ghcmh+BnFTzb9wQvZP7E8OO0IU8NaHdbYZma6q+yZRXvwHH9XaCYRa?=
 =?us-ascii?Q?meea33QyVUhscTUE9CfiqOh7BxXoAvkqBky44dfBANWlm8zQzeP9XeqXgivL?=
 =?us-ascii?Q?YbYgpoCMzdUbCsj7NjGp/tSE2P8Pr1SWokO0iz0dSc/3bAcaQPMdcx19vq1j?=
 =?us-ascii?Q?bOi2MBU8P0OgALsmu6MqsfXYqcK40S9vrZqHFACu3vHX81++xvrRLMBVh9mX?=
 =?us-ascii?Q?qkHi8DbRrk9p9imfybsAvS+/WJSdG468CIvJDLwApPblmYm6NHAqCWZzVWRl?=
 =?us-ascii?Q?ZYrRXZ+FS8F77gKZHwdqOauGWdYKLsTrQF7DTdes1rgSpeN6oQS3eh8C8laS?=
 =?us-ascii?Q?IGmhmmNb8kHGdF5pLzs79T5Qvfh9tDLooKi42nYU3p/sCITL3onIxk0JL+iu?=
 =?us-ascii?Q?y0tXb5wK3QuH3PeWu84m517xJxuY/0SmTZ+v2AQ8bc4uPloL1RsSSH99fVfF?=
 =?us-ascii?Q?aU2OKKe81hIxmp2voyNKDf6cu05xeCD4GrQwKl5NVea8b0f4KkdiVfKhQ5Gh?=
 =?us-ascii?Q?K3OcoPhdtMQbphNoARnDbrBXbEjx6vjYPJluS5fCKLMi5px8RYSa8fwB8VmR?=
 =?us-ascii?Q?GNry8qcng5FKs9pow4EJelmixwpI2uoKJFqYkyrKLyIx0YpUYPtt5NABKV2m?=
 =?us-ascii?Q?eHPNyxHdI6IdN9A31Aib/iLhncff3d9v0zcytlqCEJVIK7u2fxhWdR1BtjRL?=
 =?us-ascii?Q?7VCx3GbWeknkcM2l5LvNxYjykl+DVmF5U+udK9wxdY5kaTG2kSTm4xwbiy3h?=
 =?us-ascii?Q?+KFIQGF0r38bJajiW9VyIdTOwV55i/JcB98xWeO51NwiRPjzzw44bIxUG2vZ?=
 =?us-ascii?Q?ZbD/XccOk0GE4PBBi+Ifgx2CXzabHTrsSQ5kyPQV58suEW+A55X5Bt8qEViq?=
 =?us-ascii?Q?iin/i0I+WolzXVFxr3s7Bk8zaR3TrFvfLbYvhnpwEN7IciwLEb8vKlSQcZbq?=
 =?us-ascii?Q?WNbVeS6rWET/K9hh3SAVaGA5p4/Ht0LMPWUUDI54f1ppxnXzEzb5yvps611J?=
 =?us-ascii?Q?Ki3YtD8pxemYrZVI94Mrlli/+LZOgs7ZB6jezs+UDGK1A+d2i/xqRVt2jFhk?=
 =?us-ascii?Q?dVwJFsi14a2XDEpHU9/M07hBrC7Q4u/7GuKdRRkwWNA7v8D0CzV33TtNzsHx?=
 =?us-ascii?Q?6XTTIwAl8ef3GzBLH08PyNjpC5s0SrY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87BFD2DF6C24E641B5A503971DF17295@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee24fb7-0ceb-42a9-1698-08da52c6cb1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 14:11:39.0742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4za9XnMX99LR9qThVeRzwAkCU4m5e5Z5yszzxhrjsmZl3YcK7s3R0ebLUpmPW38S3e2eoqLOmfEtSJ9hY22Myw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_04:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200067
X-Proofpoint-GUID: 057w9mHfWGrr8PdMngfEoZIALsKR4zIK
X-Proofpoint-ORIG-GUID: 057w9mHfWGrr8PdMngfEoZIALsKR4zIK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 20, 2022, at 3:46 AM, Thorsten Leemhuis <regressions@leemhuis.info=
> wrote:
>=20
> Dennis, Chuck, I have below issue on the list of tracked regressions.
> What's the status? Has any progress been made? Or is this not really a
> regression and can be ignored?
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>=20
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>=20
> #regzbot poke
> ##regzbot unlink: https://bugzilla.kernel.org/show_bug.cgi?id=3D215890

The above link points to an Apple trackpad bug.

The bug described all the way at the bottom was the origin problem
report. I believe this is an NFS client issue. We are waiting for
a response from the NFS client maintainers to help Dennis track
this down.


> On 17.05.22 16:02, Chuck Lever III wrote:
>>> On May 17, 2022, at 9:40 AM, Dennis Dalessandro <dennis.dalessandro@cor=
nelisnetworks.com> wrote:
>>>=20
>>> On 5/13/22 10:59 AM, Chuck Lever III wrote:
>>>>>>=20
>>>>>> Ran a test with -rc6 and this time see a hung task trace on the
>>>>>> console as well
>>>>>> as an NFS RPC error.
>>>>>>=20
>>>>>> [32719.991175] nfs: RPC call returned error 512
>>>>>> .
>>>>>> .
>>>>>> .
>>>>>> [32933.285126] INFO: task kworker/u145:23:886141 blocked for more
>>>>>> than 122 seconds.
>>>>>> [32933.293543]       Tainted: G S                5.18.0-rc6 #1
>>>>>> [32933.299869] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>>>>> disables this
>>>>>> message.
>>>>>> [32933.308740] task:kworker/u145:23 state:D stack:    0 pid:886141
>>>>>> ppid:     2
>>>>>> flags:0x00004000
>>>>>> [32933.318321] Workqueue: rpciod rpc_async_schedule [sunrpc]
>>>>>> [32933.324524] Call Trace:
>>>>>> [32933.327347]  <TASK>
>>>>>> [32933.329785]  __schedule+0x3dd/0x970
>>>>>> [32933.333783]  schedule+0x41/0xa0
>>>>>> [32933.337388]  xprt_request_dequeue_xprt+0xd1/0x140 [sunrpc]
>>>>>> [32933.343639]  ? prepare_to_wait+0xd0/0xd0
>>>>>> [32933.348123]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>>>>> [32933.354183]  xprt_release+0x26/0x140 [sunrpc]
>>>>>> [32933.359168]  ? rpc_destroy_wait_queue+0x10/0x10 [sunrpc]
>>>>>> [32933.365225]  rpc_release_resources_task+0xe/0x50 [sunrpc]
>>>>>> [32933.371381]  __rpc_execute+0x2c5/0x4e0 [sunrpc]
>>>>>> [32933.376564]  ? __switch_to_asm+0x42/0x70
>>>>>> [32933.381046]  ? finish_task_switch+0xb2/0x2c0
>>>>>> [32933.385918]  rpc_async_schedule+0x29/0x40 [sunrpc]
>>>>>> [32933.391391]  process_one_work+0x1c8/0x390
>>>>>> [32933.395975]  worker_thread+0x30/0x360
>>>>>> [32933.400162]  ? process_one_work+0x390/0x390
>>>>>> [32933.404931]  kthread+0xd9/0x100
>>>>>> [32933.408536]  ? kthread_complete_and_exit+0x20/0x20
>>>>>> [32933.413984]  ret_from_fork+0x22/0x30
>>>>>> [32933.418074]  </TASK>
>>>>>>=20
>>>>>> The call trace shows up again at 245, 368, and 491 seconds. Same
>>>>>> task, same trace.
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> That's very helpful. The above trace suggests that the RDMA code is
>>>>> leaking a call to xprt_unpin_rqst().
>>>>=20
>>>> IMHO this is unlikely to be related to the performance
>>>> regression -- none of this code has changed in the past 5
>>>> kernel releases. Could be a different issue, though.
>>>>=20
>>>> As is often the case in these situations, the INFO trace
>>>> above happens long after the issue that caused the missing
>>>> unpin. So... unless Dennis has a reproducer that can trigger
>>>> the issue frequently, I don't think there's much that can
>>>> be extracted from that.
>>>=20
>>> To be fair, I've only seen this one time and have had the performance r=
egression
>>> since -rc1.
>>>=20
>>>> Also "nfs: RPC call returned error 512" suggests someone
>>>> hit ^C at some point. It's always possible that the
>>>> xprt_rdma_free() path is missing an unpin. But again,
>>>> that's not likely to be related to performance.
>>>=20
>>> I've checked our test code and after 10 minutes it does give up trying =
to do the
>>> NFS copies and aborts (SIG_INT) the test.
>>=20
>> After sleeping on it, I'm fairly certain the stack trace
>> above is a result of a gap in how xprtrdma handles a
>> signaled RPC.
>>=20
>> Signal handling in that code is pretty hard to test, so not
>> surprising that there's a lingering bug or two. One idea I
>> had was to add a fault injector in the RPC scheduler to
>> throw signals at random. I think it can be done without
>> perturbing the hot path. Maybe I'll post an RFC patch.
>>=20
>>=20
>>> So in all my tests and bisect attempts it seems the possibility to hit =
a slow
>>> NFS operation that hangs for minutes has been possible for quite some t=
ime.
>>> However in 5.18 it gets much worse.
>>>=20
>>> Any likely places I should add traces to try and find out what's stuck =
or taking
>>> time?
>>=20
>> There's been a lot of churn in that area in recent releases,
>> so I'm not familiar with the existing tracepoints. Maybe
>> Ben or Trond could provide some guidance.
>=20

--
Chuck Lever



