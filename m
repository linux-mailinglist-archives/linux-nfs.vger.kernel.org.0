Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA2588D7D
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Aug 2022 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiHCNny (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Aug 2022 09:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiHCNne (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Aug 2022 09:43:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06693C8F0
        for <linux-nfs@vger.kernel.org>; Wed,  3 Aug 2022 06:42:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273DE2m0016439;
        Wed, 3 Aug 2022 13:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IBp+lwkmuKdZIo6UUMd7w9CcxIIhIQoZytSJ+pB+2UQ=;
 b=TBX1bJHxuD8vdKH95ZlqvVr6dHrbiW2g6EIue3JnXVQU4ZzptTQrsglHXhjajMnOpm/V
 HXxefgsN7E5gX5Wr9iSymhroY1CzkBpnvsDja7mZQ5cXH9DdbT73uyiQ+RMMur5p74QT
 L80YRKYbsmqHY4LgKyLQNp8kgjnY46oUhvAUsLgQgxDBbZofNg8BVzGM2r4GqspELgs0
 ecr4sRVzIgy6yBuW3ZnNGnKU9LhTW4b/hNK1xcMzht8GpPSnNl/fLm34cdbEAccpYqT8
 7J9zFA21z0mXvSPo7zaceXpA9eJP4Zua4qoq++C4oV2BwE2up6cmZwOLJk7kt/l/gKqE FA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu811xdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 13:41:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273BKwZk031516;
        Wed, 3 Aug 2022 13:41:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu33bh6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 13:41:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4BjgHJrrdPuQmJhhrorckKij7ZgIrglm60y4oF7rKybXeKlTUvyhzF5XAriLxL3wbYgPsdhSrtPNsJ335FiwDsfgSj3B5h9xOTdW6siqiJs1cw0S1yToAHAisUINYmHvQCOhwqy6y60qGirKgyoNXCN4MufCHwnkC+PLFDo4hxgQlsHccRmhU1Qkv9ZWxzm4AKLyPdoPzgULzuKbIRfscgwnrNz3LSBhnRX1ZVO+Tt8vSyA0MnAxhgUUKRFyvL4I0f9lFJoqc7/LkxjDdPuEpv0POqvvfGLRCtmvprjGqEvazKUCNF1SN4w/+8XAEChLaTAjp12W4oxHrJTTytISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBp+lwkmuKdZIo6UUMd7w9CcxIIhIQoZytSJ+pB+2UQ=;
 b=HczONGcsDPEYm3Kh9u208UPFlsiZMS4mdXqgmYhq2fRooXRUa4hQB/Tdwwl9EcUp8NxmXiARC92c+TAWqFfOYzsaHkGYiiAWUzVjTnAX/O1M1hZOV77oY16Q0LXs9QIoIYOTZ/Gl/xY0LBYSsAa9zZPKkrJIB824LEqONjM5jnpj1zVgP5ORKr/Ans8XFfo3byVYuGCYsvY04L+jSSO4CDvfGppqqu8MYkt0CyzRTOY2w8JDXLvEN4gdzPnV+VRfBcG22asMVqTXWrS3AWIOr9V0ZVB2JG7FrPyqjd4WUFFzO0oWDPBJdapujaWZ/NUhlYdcVe/isUvBVPqmtBqQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBp+lwkmuKdZIo6UUMd7w9CcxIIhIQoZytSJ+pB+2UQ=;
 b=juBcbMXcqiXThMrvbvvwNvQdR3EFgfg96rzi+ltPaX/7br/N2SGNmMlsh484aUX07A10epE0lCKZOuakbAbTqnI/JR+SYatVf3XFnZwfaH167Tc75jUwKcvzPoDM8v81MJsJQ4W7etEwq6ijVUMESNuLP8hIPdLZ8zLVbQvbwWg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4377.namprd10.prod.outlook.com (2603:10b6:5:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Wed, 3 Aug
 2022 13:41:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 13:41:45 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [linux-next:master 13556/14285] ERROR: modpost: "set_posix_acl"
 [fs/nfsd/nfsd.ko] undefined!
Thread-Topic: [linux-next:master 13556/14285] ERROR: modpost: "set_posix_acl"
 [fs/nfsd/nfsd.ko] undefined!
Thread-Index: AQHYpwYZplOXsZmh40K/PltncN/VKa2dL30A
Date:   Wed, 3 Aug 2022 13:41:44 +0000
Message-ID: <AED75B2A-D639-422C-A744-CD40E2490E92@oracle.com>
References: <202208031404.a1NgfSzI-lkp@intel.com>
In-Reply-To: <202208031404.a1NgfSzI-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 046032d0-36c3-4890-411f-08da7555e7ea
x-ms-traffictypediagnostic: DM6PR10MB4377:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogxNah6QsiNDnm38eBveGL5jH0knU+ZTEOhw2L0XYx4WIW9zQOfoXPu5YmwWUJsBu2Qu3UQmTe2uKmg9om86GBDMDRlRPpaah2sXqQuEKy3fZv0dhGMWltiJM+rL8DVVT09z/ajnyaTxqt32SbkzAYRdrd7MgOirBlpxx0f65ZQq10lmNSceCmDuNMV1acWhHjOf08Zuf8uaTz/Dz/b6Hx9tSWPKwMNSVkMKWqrw+4bS7mWJtUlWNMAVkoN1mi3/I47+/a+S2HJwZcahWkZN9RG8w1vsrqdwpHFxwLYJWhNmOMx776tPDQFngDr6sI3m4KdqXKKwJZLE6GqidnC3kBO0dNGh/JQD2ALHQQWw13uAcUso9BcbSzKHhdIKJrKVUEbW2h76HXUKO60+i9/IdfZrDuY54rBIEGVW2r+Fvf0qym37q92jXT26L0fYlK5sBXmxZuDRwCw/BI0Yw6jUnQ5XSi/HEHBFb2vQUeCyRAMoXPAUPOA8gQyUOqEOSmmYaN38iEFhJuSpuEDKGsxnLtP0fdQNT64AgRJVRkpB/y0Cyds8WdoAY49v4FQAy8LFbYVLAgUhWhayVk0s6BzfnG0eNzdwMoFGKSfVUMgmVPMcZSSFYVr1Zuojo+URJHEmzyABbfVWEAV2XJuBrK2wmbH7mERPfmvwFfzeRzDJfLgPsaxWzsBkcswQvyN8/t8LrByrRXFPkPBtAGRqBmNfF6WLMZwlOMLgQxUHn3TzgQXcy+L+ahqH9+gv04XW6io+NczfW9LSdeqg9x54JWjA31zi5ZF/OrzMGoS0teiCgvyB6AcS1Tw/cvuXiuQNiQiUno3TlddSGjKIFIB9ubrYR5amS8+V5bnkOuQOkcyj/OZXgqvIsv6RjsDEBKUKWGoU78x1KzzTFdaBNTGDTwhGUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(6486002)(966005)(76116006)(71200400001)(6916009)(316002)(38070700005)(91956017)(478600001)(66946007)(5660300002)(66556008)(2616005)(8676002)(54906003)(4326008)(8936002)(64756008)(66476007)(66446008)(36756003)(86362001)(83380400001)(122000001)(33656002)(41300700001)(2906002)(186003)(38100700002)(6512007)(53546011)(26005)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4bB7DCYBs8uQOb5LCbqGOiszSiQw2kp65oW+ayTSIw5hwvTrVTubmKFNe/K4?=
 =?us-ascii?Q?A26ebu1V9i0+y0bnxMNdx/HG8UlqhKkMzHWflliG4nIR0Sqca/Qhe8as+dr8?=
 =?us-ascii?Q?QDFV9d++qxcKcF/RtCoj9j28bYh4kFsdCWa9AWu2DQZPuYLA0ewxzrY09emg?=
 =?us-ascii?Q?FynZ+mm48skagbkjkSeBMSXw9GN1tr06IV3D+5fWHtHlmpWJQBwN28SV0CPx?=
 =?us-ascii?Q?bSx1LZoUQSheTYlHHWiXwj5w7eWUzey4Wd4kyhR8jvlvRhi9iYQKcVmagc1A?=
 =?us-ascii?Q?5W2W9uSzftZF1SAJNbn4bScT9d/5ZpGtdSxLAw3a6E1yuLdFCXUg9r2vl56z?=
 =?us-ascii?Q?rJvE/buOWE38TXHpYG4Zi+z+n4iA0YIFqKETpudmJYQg2Zlpme8tVBad0bUG?=
 =?us-ascii?Q?QDT2CABUjcf2KIQ1wu/a/8lrHMLw2SSvYP97JJMu73GH9SvnZyN30j1e5AWX?=
 =?us-ascii?Q?2JwlQnzpEeo+nmrtcd1WsFaNOyhMYKTAzUVUj2PgzGnwmMZYDb0UkVM0Cdho?=
 =?us-ascii?Q?nec+9++MvJtkLKl69It5A4FC99stffKUUxG7JrAd6Y+DPiaehaIOfLb76j17?=
 =?us-ascii?Q?ggAOcx8EBeMOdlUcqVLkGYVmm86xvurvoHvhRj/gVsSalb2ZhajR2CG1uAbB?=
 =?us-ascii?Q?POw6KxDnjmIIahxQXg7F/kjxEDG3SZf9XcxmNzEi67PVo4tJ7AFko5W21LeB?=
 =?us-ascii?Q?E5iDRHANGUqj5Qrl1I2LmBpvh44iVvCdXNIxjFJwawKmiFTay/hECTq0uxor?=
 =?us-ascii?Q?Oy58Gh6yGPeFkf4edl4vPlKVWvVFHbv5Bkv85gG2AK+St7wjNydY2b9m6SRa?=
 =?us-ascii?Q?WYYhxMKqNa1fo0U/Th0L4BrLEgJKWeeXnyGjwDZxm9L/HzoXsBj/ICt4U+XC?=
 =?us-ascii?Q?hU1LIVCsaejg/4DQaTYaYuEbybFkLPo6qqswShjz7UshVTMzfsLk9VsW3GoL?=
 =?us-ascii?Q?rUVZK6xAXKuiG4mIbg+RVzZdK9plVnrL2+EqQtp8ezRCtW36Rs6NBu67O5R9?=
 =?us-ascii?Q?l1dp6zf2CtuzSKFB0iaZ5DvraeVta6jcm4PQxeiPIrfBQ5jNalDw3FNSZiwB?=
 =?us-ascii?Q?zjHqvkf8qNuAmGnP9euTDWTxlFTSzZC8nfK2bDtseBa/0MJbcfk9TJX+3ay7?=
 =?us-ascii?Q?BMP0Tuo8yMvyGazX4SxC1lStUV/rlR9ey1QXoAm9vaFdzECMYDR4ksx7Lssx?=
 =?us-ascii?Q?Bj9kPt+zqsISpUTXmK39YB2SPwgrkdAciXijPDwyRxxyLUM0KMG2ktQxmRAt?=
 =?us-ascii?Q?um8OhXQcX33TlzQI1cFSIhjLaKB6RLO8bEkInphKDwYanavzwWtXgkd5as3D?=
 =?us-ascii?Q?FcCCTUrPZt1ALc3R6+m7sOYhBxXJnR94w/A6pjsT8GONn+evsEZycx/Opb3y?=
 =?us-ascii?Q?PW4HlkOcn8gr8lcy0FwZgkm/4tiol7mMSeCjStbt/VbMFnTCxySvLOVD16di?=
 =?us-ascii?Q?cnJyhFk9ptTDvZUtE11eoNnHKunNnt5qTCcf8Qzs8WwS9DJkQlw79eE5CKqe?=
 =?us-ascii?Q?xuBuc2YysdCImwHaIbBdTbfS6RLTRcaRvK2R29ih1GmWfYiGFbSa0bjBzbYR?=
 =?us-ascii?Q?r+t6gl8qH7vY/cdKa+8L3/7nqZNwL+YmfFfI9pDu1ZbWNwSA8xzRTsmvEyFl?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <503AAB3C5FDE8948BA6A223740CE3009@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046032d0-36c3-4890-411f-08da7555e7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 13:41:44.9749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9kb+Dw09Fol18/jhAgjVZpn0wlwN798fwfVOm+aW18nLgtYPe9VfkYmB9IV8B00ZBp2L0kAUxkZjng+I/6B0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030061
X-Proofpoint-ORIG-GUID: uVNvGLS7v1PYhdjsGFNaxDC6H-b8i-7_
X-Proofpoint-GUID: uVNvGLS7v1PYhdjsGFNaxDC6H-b8i-7_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 3, 2022, at 2:55 AM, kernel test robot <lkp@intel.com> wrote:
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it master
> head:   42d670bda02fdba0f3944c92f545984501e5788d
> commit: 2743f3e0444f7287161ecf3e464ee2733dde412d [13556/14285] NFSD: add =
posix ACLs to struct nfsd_attrs
> config: parisc-defconfig (https://download.01.org/0day-ci/archive/2022080=
3/202208031404.a1NgfSzI-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin=
/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git/commit/?id=3D2743f3e0444f7287161ecf3e464ee2733dde412d
>        git remote add linux-next https://git.kernel.org/pub/scm/linux/ker=
nel/git/next/linux-next.git
>        git fetch --no-tags linux-next master
>        git checkout 2743f3e0444f7287161ecf3e464ee2733dde412d
>        # save the config file
>        mkdir build_dir && cp config build_dir/.config
>        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cros=
s W=3D1 O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
>>> ERROR: modpost: "set_posix_acl" [fs/nfsd/nfsd.ko] undefined!
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

Neil, I've reproduced this and confirmed that the following addresses
the error:

 464 #ifdef CONFIG_FS_POSIX_ACL
 465         if (attr->na_pacl)
 466                 attr->na_aclerr =3D set_posix_acl(&init_user_ns,
 467                                                 inode, ACL_TYPE_ACCESS=
,
 468                                                 attr->na_pacl);
 469         if (!attr->na_aclerr && attr->na_dpacl && S_ISDIR(inode->i_mod=
e))
 470                 attr->na_aclerr =3D set_posix_acl(&init_user_ns,
 471                                                 inode, ACL_TYPE_DEFAUL=
T,
 472                                                 attr->na_dpacl);
 473 #endif

I can squash this change into ("NFSD: add posix ACLs to struct nfsd_attrs")=
.

--
Chuck Lever



