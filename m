Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9093864A848
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 20:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiLLTsd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 14:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiLLTsb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 14:48:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C324C167DA
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 11:48:28 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGwXo7002224;
        Mon, 12 Dec 2022 19:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=0+jZmCILGodQUHFdhvImtWPoea6/nT8u1sK2dgxCjQs=;
 b=MHLJYaG/QTdAUyTB3CFLcnsMOizk/t8xy8RIPOynjEcIZTmvqmi1hl+ZGFlN152V0DhP
 d61pV1NSYfWgPdJpLgTUKQ26zbqQxu6GSGqb+wdmZM+wu7gDWLs4GnY/TLBDjck2Zmc2
 cDsJ6i4klFsoDaE1H2f/Pb3PllJIyVzX9GoICFuT+SfTsD3BY4HpZHWhgMXWJRj7CTb4
 W1JSs9b9AR4w1qQJtcsh4H+k+Z4+ssAMQd+chkQDcvq+Eqvu2IF82nzVgyuBm5IqaiRz
 eH89ht2nvagRpo9ENI1eXcidA7L0aLG8N8/ARAKy6nf5x1tUrzhDbewl9E356UJFGoJs qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mcj5bur9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:48:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BCIe75A018562;
        Mon, 12 Dec 2022 19:48:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mcgjb1wux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Dec 2022 19:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeRV5irlPyxhDJN5/qEcFSR3ZqpZcuk3VMSgEBeYw+v1v5P4FcNXRRf11pvgWRFxylCeqLnnZT9qLLGPSmLSvMoH2vRjNMFZWoX7CrtJI5IgouVHEKtEp52qg0QVP/KG517dbfkyCgRposDJ794A2dIj1ddcPvNXVmVfjO8aO2pu7LwSORiDOvsVjRKv1atreH5lOXEZWyEUwzzGdb2SuQf5Tz1GkHCQx996MN5iw/HLoji5aix7Hl8tcZNdHNQvjt7SzRFqUiu+2aVGKFIIIve4IjOU5rWrAdU9LLFNR3MXW2GbV6QbNr6EjieiyqiHfsnW+BSK2+ykPLkAbXmzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+jZmCILGodQUHFdhvImtWPoea6/nT8u1sK2dgxCjQs=;
 b=ey1BeuzgdCBSExubVtzEMGsve1TQONiHWqWuxCe5CCOZLzJI0tIX8IkgRWsUDDUNRd7NMrLn1VvO4UNbshiIaDLtLwlvFIPnmkQ4hmf2dlx79KqLPTQOXd+97wi79MAPT1a/INmMVE0WI1X9vqM6nE+xt5+IAJbp4wipJMdvd+MHNKjbpHvoKU15geUrRx6cjOtk/x1U3wfbRyIkRU0kb7QHb8NhLF8jYgmPhCZ3AS7gqJvtOa4xsQVeIVdRx5EdAJdKna5eRPPcMGwSYVDIc4uoB+NhjMRy/rNXx+nAh6+yXE2KJwnq0WxPqAEfBoKc2Y2aS6swp0sDLvG9SwtUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+jZmCILGodQUHFdhvImtWPoea6/nT8u1sK2dgxCjQs=;
 b=xomxulg/yOFo6xrUlrfx7N6PwxutLRbkJyyHZKfAWTe9N9SK+5/A6gTwIFm30YgYb5eNtJitKv3s7toVv6mmvIb3oo0ysCtmNhbbWeWfImF3j7Xcj0uc98kt9LT2mO6WSILkjbR4gbq1JXICbYC9HDw88jcEqAubpgz9Dw3wpQs=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 19:48:14 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::773f:eb65:8d20:f9c8%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 19:48:14 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Greg KH <gregkh@linuxfoundation.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        "hdthky0@gmail.com" <hdthky0@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Topic: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
Thread-Index: AQHZDZX0xFKY8ZoZ9kagScnVZShYCK5qLYgAgAAUMoCAAAG1gIAABUyAgAAI5YCAAC2LgIAACFOAgAAJJACAAAYsgIAACqCAgAADN4CAAATygIAAAJOA
Date:   Mon, 12 Dec 2022 19:48:13 +0000
Message-ID: <1EAC1016-CB25-4695-A035-5DA2AA5EF58A@oracle.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
 <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
 <56b0cb4f-dfe9-6892-7fef-1a2965cf1d99@oracle.com>
 <0ab8efccae708faa092a56c6935c33564814bfed.camel@kernel.org>
 <Y5czwRabTFiwah2b@kroah.com>
 <a47cc610af621e95ba359388e93d988f1ef5b17f.camel@kernel.org>
 <Y5dha1Hcgolctt0K@kroah.com>
 <7365935036c192bfc64cda41cb9ccb297e3eb86f.camel@kernel.org>
 <6D5F96AA-A8A7-4E19-A566-959F19A3CB0A@oracle.com>
 <6200943464679d51de50a05ab2ca1cc0c91d8685.camel@kernel.org>
 <a895cb89-f8f3-a2e1-1958-cf9379ecdcd5@oracle.com>
 <4CAE538E-9F0B-4B44-956E-C6498A37A83A@oracle.com>
 <aefea8e45e99ba948acf4c5744793b6ad674a66c.camel@kernel.org>
In-Reply-To: <aefea8e45e99ba948acf4c5744793b6ad674a66c.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR10MB5131:EE_|SA1PR10MB6365:EE_
x-ms-office365-filtering-correlation-id: dd8d82c4-499a-4b83-37bb-08dadc79ce7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzKMvO05KoBq0TA/aVj5QrK69au+a/f5kyTM1xF4inBzLQnKKzJ23oL1dm3bd9sn7Ia55y25rBvV3O16jb5HEFBvG1whtEcZiWWO/0kkJ38Eued7h1gHaTAtodxtNC7eperl3y6+AMgqtBJcb+csAkmMOdhg9qXJqy826VrhAzNR+eIz9xWoa9s/taPR2mfJ6vowUdevBtgqWbiouF3Gxipzw9XC9I4G8yvNZt6KlmEw9VzcGCzE880YEsA8zWEN2H60JjbN6awhqN62GOXio8jHMGFbSjkZP+xD0zl6tUPzSq9Jpht9eO+Pl0ecAmfbxF3lov1cqBg18h/TA246Dh8dT/Zp28jxsib9Vriv+1YllS3FiPlrcMCPrfClyY6XlsRE0EKu0KvJL3ji9Plg+cJy4WEUCDJ3dhR5oK6Am/7zWjx0kpLuN3+mSwIRHesWN76SwoZ4MELal8CUg2SY5s72TJHjkNv+gxw7Dx7rLxh4sfMNgIvEtYej9V9CvHD9Ym04SDIpi6AWBX9GQKrB+3AXS+beRyVaLThlBQpVX5GisJhXSd1jUU0ZWxb1y7Nyro6MGfENthjvZ4hhJk0i5Qzem3Wgd6ssiF5XHxViougWELb1MOedYJ3nGXhtuL3lBYlt6+yEC+zxwxG0xQommKmwGKEwPzW6bBm6HIohHkaDsyWcVeBx5h+P08SUI3YArm2KTVAjHbNOextNBEIXm+w1obZWhQM+spRTT73urlc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(38100700002)(122000001)(30864003)(4001150100001)(2906002)(38070700005)(66899015)(478600001)(6486002)(41300700001)(186003)(6512007)(26005)(6506007)(8936002)(53546011)(64756008)(66556008)(8676002)(66946007)(66446008)(76116006)(66476007)(5660300002)(36756003)(4326008)(71200400001)(2616005)(86362001)(316002)(54906003)(83380400001)(6916009)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w0G9eREaDrRuuMs5dS40kjuiIWGZuF2YcXNqpughjPNr3Obo5sDa/EKMVPbq?=
 =?us-ascii?Q?3Vy4K+QMwDqWclTrienyWO+9gFBDUkjxzI44wq6tMj9ue834TarDB/mfmSoi?=
 =?us-ascii?Q?dD7jmJO+aiwvp0QdNQ0fLVQgG4Pb/sP68V3ektoKheHqdUs4xcz6xnwD5ocd?=
 =?us-ascii?Q?jfP9HWdg9IHtMz2FBPaZTa43iCKFSupZxXthXRvLJEB30AfJsKBh/Wu3MGxl?=
 =?us-ascii?Q?RB6o//pY0qoWgoJckm6lunFAC22qd9ds7n/GU0+FXq1/iuGeEw7276AfxI12?=
 =?us-ascii?Q?Do8AkMYnoO0BiHwznLjoPU0XgA/kPFj/0HLnNmC4aiG+hLjRTWEC34Sv5LNn?=
 =?us-ascii?Q?i/0QUZSr5Fz1Bh83cyFOMEg7KK9CYwW2TvepsCBm8Fr7WDH1q6eCZ3OZi/pa?=
 =?us-ascii?Q?sOgJM+so8BeTJfSVL0ymcmL6GbZX6FtwSuYNPboCwweRHgPgbDIdGgk8qdop?=
 =?us-ascii?Q?uGG6QUSItdJv0rrVhMPViZKSRXSXuS9XABlvTyRjSw2bIRWTZS1PeaJB4pec?=
 =?us-ascii?Q?AJ2KUAhR6eavX9dKzC76hGFSJ5+XRgznU+GE7W7rCOjk7kFEvxFFpVCcIYxm?=
 =?us-ascii?Q?dYoCK1BNrLkh/uj6u16r6ZXJB6REp4Ik6qbw5fwU1ZPf+Tadh/aXEPKAC315?=
 =?us-ascii?Q?/2xw3Z6ZpW3Gv1EmeFwlmP9YZ5cDqtFHzBRsx0jhbV4U3C2aSyDQEM5ViUJO?=
 =?us-ascii?Q?NEdzZmwjMouz0sxWTLEh3UHgcu0ChsBz2/Hlv+rUmtnWr24YArDu6Qzuu8Bq?=
 =?us-ascii?Q?gzRq7LwR4nvPMlsWqCrGnVtJ9OAiZqzScxnCynbIIrbbkoATGVgAcwLa+/EE?=
 =?us-ascii?Q?fKrpULVWNa9fcYgtc3MWk7u3YeUFWT6wHYIWT0MIZdZ0NzK/sytFLYGcrFam?=
 =?us-ascii?Q?Dkn0O8HCms8aDTnRqUITM1hMwC0jgCy/yGFUqANJFNfOQu48toaAz9IjlXHD?=
 =?us-ascii?Q?UUFuuwXM/Er8+CPggx1r/5pvt3crKkJ9Hss0fSO3xnLtMjdaEYGwXHWvruaS?=
 =?us-ascii?Q?8NcEZIsif5FFscaHSU2+UnPBkOEM88Whc0XDBZAKgZ3jhBEh3GCsxbDP6sJg?=
 =?us-ascii?Q?Fc+BY48DrkQtGMA2Yw9vcfB1HxZ+NT++DqLj+SPuzaxlTUfA7mEJr03JDf5d?=
 =?us-ascii?Q?uzlgtUxQxCmjfpa3zSVPQjN92olc0ZORgzGtZZNeEqBYe5SvoKo6NdTrF0fw?=
 =?us-ascii?Q?2/72K5Jwhi+Nq5IJjWjgqFEn7HV3KkPNpR8Jx8IbMHQGLw5rj4XdG4V9PqxW?=
 =?us-ascii?Q?sQwyAnk8ce6syS8Btr5EbdNS1eiDuLGxMeremqGExgGMmCqKn6lWjxukfmxr?=
 =?us-ascii?Q?yFk6x43qUc7aHOVxJ/CvSALrbXV6srE8K2HP0N/8yAkq55ezRYPtrLKN274G?=
 =?us-ascii?Q?aa9zI7ZV3MPzS1RNv0yrzw2OLyabzksnXp69H5EgB4w2LXZpSMWVy7CGc9b4?=
 =?us-ascii?Q?8f+P0h0t48wH+wNQRJ8jFB6VwkAFblJ6jQol/NDXDlKYRJs2Z/w33yAHisL2?=
 =?us-ascii?Q?6qDTL/ohkCBCyMMfXyBjZnpH6Kx5pmpCl5chTinHAzyDY6bX5mxrrcVChW3/?=
 =?us-ascii?Q?6ZN567co9V6yi0l6njuS+9rqllrKWu3yIINfFssRpgkUizCEzR8YFgcJSysP?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <637C59BE5210CF44AAA5C524217A7CFF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8d82c4-499a-4b83-37bb-08dadc79ce7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 19:48:13.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZB/SDRTt5MCK4d8bQ7fxNTPT8s/W2Jo+apkk1ePicVGdWANh9akteVJMlyBKdCpU6aB99MKRNMDm5xJMe11cKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120178
X-Proofpoint-GUID: tbUGS0QE_QRintB7heyuPf7oJa4fGqO1
X-Proofpoint-ORIG-GUID: tbUGS0QE_QRintB7heyuPf7oJa4fGqO1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 12, 2022, at 2:46 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Mon, 2022-12-12 at 19:28 +0000, Chuck Lever III wrote:
>>=20
>>> On Dec 12, 2022, at 2:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>>=20
>>> On 12/12/22 10:38 AM, Jeff Layton wrote:
>>>> On Mon, 2022-12-12 at 18:16 +0000, Chuck Lever III wrote:
>>>>>> On Dec 12, 2022, at 12:44 PM, Jeff Layton <jlayton@kernel.org> wrote=
:
>>>>>>=20
>>>>>> On Mon, 2022-12-12 at 18:14 +0100, Greg KH wrote:
>>>>>>> On Mon, Dec 12, 2022 at 09:31:19AM -0500, Jeff Layton wrote:
>>>>>>>> On Mon, 2022-12-12 at 14:59 +0100, Greg KH wrote:
>>>>>>>>> On Mon, Dec 12, 2022 at 08:40:31AM -0500, Jeff Layton wrote:
>>>>>>>>>> On Mon, 2022-12-12 at 05:34 -0800, dai.ngo@oracle.com wrote:
>>>>>>>>>>> On 12/12/22 4:22 AM, Jeff Layton wrote:
>>>>>>>>>>>> On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
>>>>>>>>>>>>> Problem caused by source's vfsmount being unmounted but remai=
ns
>>>>>>>>>>>>> on the delayed unmount list. This happens when nfs42_ssc_open=
()
>>>>>>>>>>>>> return errors.
>>>>>>>>>>>>> Fixed by removing nfsd4_interssc_connect(), leave the vfsmoun=
t
>>>>>>>>>>>>> for the laundromat to unmount when idle time expires.
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
>>>>>>>>>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> fs/nfsd/nfs4proc.c | 23 +++++++----------------
>>>>>>>>>>>>> 1 file changed, 7 insertions(+), 16 deletions(-)
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>>>>>>>>> index 8beb2bc4c328..756e42cf0d01 100644
>>>>>>>>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>>>>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>>>>>>>>> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_serv=
er *nss, struct svc_rqst *rqstp,
>>>>>>>>>>>>> 	return status;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> -static void
>>>>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>>>>> -{
>>>>>>>>>>>>> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
>>>>>>>>>>>>> -	mntput(ss_mnt);
>>>>>>>>>>>>> -}
>>>>>>>>>>>>> -
>>>>>>>>>>>>> /*
>>>>>>>>>>>>>  * Verify COPY destination stateid.
>>>>>>>>>>>>>  *
>>>>>>>>>>>>> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmoun=
t *ss_mnt, struct file *filp,
>>>>>>>>>>>>> {
>>>>>>>>>>>>> }
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> -static void
>>>>>>>>>>>>> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
>>>>>>>>>>>>> -{
>>>>>>>>>>>>> -}
>>>>>>>>>>>>> -
>>>>>>>>>>>>> static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>>>>>>>>>>>>> 				   struct nfs_fh *src_fh,
>>>>>>>>>>>>> 				   nfs4_stateid *stateid)
>>>>>>>>>>>>> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *da=
ta)
>>>>>>>>>>>>> 		struct file *filp;
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> 		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
>>>>>>>>>>>>> -				      &copy->stateid);
>>>>>>>>>>>>> +					&copy->stateid);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> 		if (IS_ERR(filp)) {
>>>>>>>>>>>>> 			switch (PTR_ERR(filp)) {
>>>>>>>>>>>>> 			case -EBADF:
>>>>>>>>>>>>> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *da=
ta)
>>>>>>>>>>>>> 			default:
>>>>>>>>>>>>> 				nfserr =3D nfserr_offload_denied;
>>>>>>>>>>>>> 			}
>>>>>>>>>>>>> -			nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>>>>> +			/* ss_mnt will be unmounted by the laundromat */
>>>>>>>>>>>>> 			goto do_callback;
>>>>>>>>>>>>> 		}
>>>>>>>>>>>>> 		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
>>>>>>>>>>>>> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, str=
uct nfsd4_compound_state *cstate,
>>>>>>>>>>>>> 	if (async_copy)
>>>>>>>>>>>>> 		cleanup_async_copy(async_copy);
>>>>>>>>>>>>> 	status =3D nfserrno(-ENOMEM);
>>>>>>>>>>>>> -	if (nfsd4_ssc_is_inter(copy))
>>>>>>>>>>>>> -		nfsd4_interssc_disconnect(copy->ss_mnt);
>>>>>>>>>>>>> +	/*
>>>>>>>>>>>>> +	 * source's vfsmount of inter-copy will be unmounted
>>>>>>>>>>>>> +	 * by the laundromat
>>>>>>>>>>>>> +	 */
>>>>>>>>>>>>> 	goto out;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>=20
>>>>>>>>>>>> This looks reasonable at first glance, but I have some concern=
s with the
>>>>>>>>>>>> refcounting around ss_mnt elsewhere in this code. nfsd4_ssc_se=
tup_dul
>>>>>>>>>>>> looks for an existing connection and bumps the ni->nsui_refcnt=
 if it
>>>>>>>>>>>> finds one.
>>>>>>>>>>>>=20
>>>>>>>>>>>> But then later, nfsd4_cleanup_inter_ssc has a couple of cases =
where it
>>>>>>>>>>>> just does a bare mntput:
>>>>>>>>>>>>=20
>>>>>>>>>>>>        if (!nn) {
>>>>>>>>>>>>                mntput(ss_mnt);
>>>>>>>>>>>>                return;
>>>>>>>>>>>>        }
>>>>>>>>>>>> ...
>>>>>>>>>>>>        if (!found) {
>>>>>>>>>>>>                mntput(ss_mnt);
>>>>>>>>>>>>                return;
>>>>>>>>>>>>        }
>>>>>>>>>>>>=20
>>>>>>>>>>>> The first one looks bogus. Can net_generic return NULL? If so =
how, and
>>>>>>>>>>>> why is it not a problem elsewhere in the kernel?
>>>>>>>>>>> it looks like net_generic can not fail, no where else check for=
 NULL
>>>>>>>>>>> so I will remove this check.
>>>>>>>>>>>=20
>>>>>>>>>>>> For the second case, if the ni is no longer on the list, where=
 did the
>>>>>>>>>>>> extra ss_mnt reference come from? Maybe that should be a WARN_=
ON or
>>>>>>>>>>>> BUG_ON?
>>>>>>>>>>> if ni is not found on the list then it's a bug somewhere so I w=
ill add
>>>>>>>>>>> a BUG_ON on this.
>>>>>>>>>>>=20
>>>>>>>>>> Probably better to just WARN_ON and let any references leak in t=
hat
>>>>>>>>>> case. A BUG_ON implies a panic in some environments, and it's be=
st to
>>>>>>>>>> avoid that unless there really is no choice.
>>>>>>>>> WARN_ON also causes machines to boot that have panic_on_warn enab=
led.
>>>>>>>>> Why not just handle the error and keep going?  Why panic at all?
>>>>>>>>>=20
>>>>>>>> Who the hell sets panic_on_warn (outside of testing environments)?
>>>>>>> All cloud providers and anyone else that wants to "kill the system =
that
>>>>>>> had a problem and have it reboot fast" in order to keep things work=
ing
>>>>>>> overall.
>>>>>>>=20
>>>>>> If that's the case, then this situation would probably be one where =
a
>>>>>> cloud provider would want to crash it and come back. NFS grace perio=
ds
>>>>>> can suck though.
>>>>>>=20
>>>>>>>> I'm
>>>>>>>> suggesting a WARN_ON because not finding an entry at this point
>>>>>>>> represents a bug that we'd want reported.
>>>>>>> Your call, but we are generally discouraging adding new WARN_ON() f=
or
>>>>>>> anything that userspace could ever trigger.  And if userspace can't
>>>>>>> trigger it, then it's a normal type of error that you need to handl=
e
>>>>>>> anyway, right?
>>>>>>>=20
>>>>>>> Anyway, your call, just letting you know.
>>>>>>>=20
>>>>>> Understood.
>>>>>>=20
>>>>>>>> The caller should hold a reference to the object that holds a vfsm=
ount
>>>>>>>> reference. It relies on that vfsmount to do a copy. If it's gone a=
t this
>>>>>>>> point where we're releasing that reference, then we're looking at =
a
>>>>>>>> refcounting bug of some sort.
>>>>>>> refcounting in the nfsd code, or outside of that?
>>>>>>>=20
>>>>>> It'd be in the nfsd code, but might affect the vfsmount refcount. In=
ter-
>>>>>> server copy is quite the tenuous house of cards. ;)
>>>>>>=20
>>>>>>>> I would expect anyone who sets panic_on_warn to _desire_ a panic i=
n this
>>>>>>>> situation. After all, they asked for it. Presumably they want it t=
o do
>>>>>>>> some coredump analysis or something?
>>>>>>>>=20
>>>>>>>> It is debatable whether the stack trace at this point would be hel=
pful
>>>>>>>> though, so you might consider a pr_warn or something less log-spam=
my.
>>>>>>> If you can recover from it, then yeah, pr_warn() is usually best.
>>>>>>>=20
>>>>>> It does look like Dai went with pr_warn on his v2 patch.
>>>>>>=20
>>>>>> We'd "recover" by leaking a vfsmount reference. The immediate crash
>>>>>> would be avoided, but it might make for interesting "fun" later when=
 you
>>>>>> went to try and unmount the thing.
>>>>> This is a red flag for me. If the leak prevents the system from
>>>>> shutting down reliably, then we need to do something more than
>>>>> a pr_warn(), I would think.
>>>>>=20
>>>> Sorry, I should correct myself.
>>>>=20
>>>> We wouldn't (necessarily) leak a vfsmount reference. If the entry was =
no
>>>> longer on the list, then presumably it has already been cleaned up and
>>>> the vfsmount reference put.
>>>=20
>>> I think the issue here is not vfsmount reference count. The issue is th=
at
>>> we could not find a nfsd4_ssc_umount_item on the list that matches the
>>> vfsmount ss_mnt. So the question is what should we do in this case?
>>>=20
>>> Prior to this patch, when we hit this scenario we just go ahead and
>>> unmount the ss_mnt there since it won't be unmounted by the laundromat
>>> (it's not on the delayed unmount list).
>>>=20
>>> With this patch, we don't even unmount the ss_mnt, we just do a pr_warn=
.
>>>=20
>>> I'd prefer to go back to the previous code to do the unmount and also
>>> do a pr_warn.
>>>=20
>>>> It's still a bug though since we _should_ still have a reference to th=
e
>>>> nfsd4_ssc_umount_item at this point. So this is really just a potentia=
l
>>>> use-after-free.
>>>=20
>>> The ss_mnt still might have a reference on the nfsd4_ssc_umount_item
>>> but we just can't find it on the list. Even though the possibility for
>>> this to happen is from slim to none, we still have to check for it.
>>>=20
>>>> FWIW, the object handling here is somewhat weird as the copy operation
>>>> holds a reference to the nfsd4_ssc_umount_item but passes around a
>>>> pointer to the vfsmount
>>>>=20
>>>> I have to wonder if it'd be cleaner to have nfsd4_setup_inter_ssc pass
>>>> back a pointer to the nfsd4_ssc_umount_item, so you could pass that to
>>>> nfsd4_cleanup_inter_ssc and skip searching for it again at cleanup tim=
e.
>>>=20
>>> Yes, I think returning a pointer to the nfsd4_ssc_umount_item approach
>>> would be better.  We won't have to deal with the situation where we can=
't
>>> find an item on the list (even though it almost never happen).
>>>=20
>>> Can we do this enhancement after fixing this use-after-free problem, in
>>> a separate patch series?
>=20
> ^^^
> I think that'd be best.
>=20
>> Is there a reason not fix it correctly now?
>>=20
>> I'd rather not merge a fix that leaves the possibility of a leak.
>=20
> We're going to need to backport this to earlier kernels and it'll need
> to go in soon. I think it'd be to take a minimal fix for the reported
> crash, and then Dai can have some time to do a larger cleanup.

Backporting is important, of course.

What I was hearing was that the simple fix couldn't be done without
introducing a leak or UAF.


--
Chuck Lever



